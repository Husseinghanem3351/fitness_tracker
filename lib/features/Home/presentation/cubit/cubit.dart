import 'dart:async';
import 'dart:convert';
import 'package:fitness_tracker/features/Home/presentation/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../global/global.dart';
import '../../data/cache helper.dart';
import '../../data/model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitHomeState());

  static HomeCubit get(BuildContext context) => BlocProvider.of<HomeCubit>(context);

  bool showAddButton = false;

  void changeAddButtonState() {
    showAddButton = !showAddButton;
    emit(ChangeAddButtonState());
  }

  double liters = 0;

  void addGlass({double? litersChange}) {
    if (litersChange != null) {
      liters = litersChange;
    } else {
      liters += .25;
    }
    updatePetMood();
    emit(ChangeAddButtonState());
  }

  void removeGlass() {
    if (liters >= 0.25) {
      liters -= 0.25;
      updatePetMood();
      emit(ChangeAddButtonState());
    }
  }

  String goal = '';
  String activeLevel = '';
  String gender = 'Female';

  Future<void> calculateBmr() async {
    emit(CalculateBmrLoading());
    var data = await CacheHelper.getData(key: 'personalInfo');
    if (data != null) {
      personalInfo = PersonalInfoModel.fromJson(jsonDecode(data));
      gender = personalInfo!.gender;
      activeLevel = await CacheHelper.getData(key: 'activityLevel') ?? 'Sedentary';
      goal = await CacheHelper.getData(key: 'goal') ?? 'maintain weight';
      
      double calculatedBmrValue = 0;
      
      // Mifflin-St Jeor Equation (Clinical Standard)
      // Reference: Mifflin MD, St Jeor ST, et al. Am J Clin Nutr. 1990
      if (gender == 'Male') {
        calculatedBmrValue = (10 * personalInfo!.weight) +
            (6.25 * personalInfo!.height) -
            (5 * personalInfo!.age) + 5;
      } else {
        calculatedBmrValue = (10 * personalInfo!.weight) +
            (6.25 * personalInfo!.height) -
            (5 * personalInfo!.age) - 161;
      }
      
      // Activity Factor (TDEE - Total Daily Energy Expenditure)
      double activityFactor = 1.2;
      switch (activeLevel) {
        case 'Sedentary' || 'كسول':
          activityFactor = 1.2; // Little or no exercise
          levelIndex = 0;
          break;
        case 'lightly Active' || 'خفيف النشاط':
          activityFactor = 1.375; // Light exercise 1-3 days/week
          levelIndex = 1;
          break;
        case 'Moderately Active' || 'متوسط النشاط':
          activityFactor = 1.55; // Moderate exercise 3-5 days/week
          levelIndex = 2;
          break;
        case 'very Active' || 'نشط جدا':
          activityFactor = 1.725; // Hard exercise 6-7 days/week
          levelIndex = 3;
          break;
        case 'Extra Active' || 'نشط للغاية':
          activityFactor = 1.9; // Very hard exercise & physical job
          levelIndex = 4;
          break;
      }
      
      double tdee = calculatedBmrValue * activityFactor;
      
      // Goal Adjustment
      switch (goal) {
        case 'lose weight' || 'خسارة وزن':
          tdee -= 500; // Clinical recommendation for safe weight loss
          goalIndex = 0;
          break;
        case 'gain weight' || 'زيادة وزن':
          tdee += 500; // Standard surplus for healthy weight gain
          goalIndex = 2;
          break;
        case 'build muscle' || 'بناء عضلات':
          tdee += 250; // Lean muscle surplus to minimize fat gain
          goalIndex = 3; 
          break;
        default:
          goalIndex = 1;
      }

      // Safety minimums (WHO/NHS standards)
      if (gender == 'Female' && tdee < 1200) tdee = 1200;
      if (gender == 'Male' && tdee < 1500) tdee = 1500;
      
      dailyGoalCalories = tdee;
      eatRemainingCalories = dailyGoalCalories - eatingCalories + burningCalories;
      _updateMacroGoals(dailyGoalCalories);
    }
  }

  void _updateMacroGoals(double budget) {
    // Reference: Acceptable Macronutrient Distribution Ranges (AMDR)
    // National Academies of Sciences, Engineering, and Medicine.
    
    String goalStr = goal;
    double pRatio, fRatio, cRatio;

    switch (goalStr) {
      case 'lose weight' || 'خسارة وزن':
        // High protein/Lower carb for satiety during deficit
        pRatio = 0.25; // 25% protein
        fRatio = 0.25; // 25% fat
        cRatio = 0.50; // 50% carb
        break;
      case 'build muscle' || 'بناء عضلات':
        // Higher protein for repair
        pRatio = 0.30; // 30% protein
        fRatio = 0.25; // 25% fat
        cRatio = 0.45; // 45% carb
        break;
      default:
        // Balanced health standards (AMDR Standard)
        pRatio = 0.20; // 20% protein (Realistic & Healthy)
        fRatio = 0.30; // 30% fat
        cRatio = 0.50; // 50% carb
    }

    requiredProtein = (pRatio * budget) / 4;
    requiredFat = (fRatio * budget) / 9;
    requiredCarb = (cRatio * budget) / 4;
  }

  // Called by DetailsCubit when activities are added/removed
  void refreshDashboard(double burnedCals) async {
    // 1. Recalculate base BMR and initial macro goals
    await calculateBmr();
    
    // 2. Dynamically increase macro goals based on actual exercise done
    if (burnedCals > 0) {
      requiredCarb += (burnedCals * 0.5) / 4;
      requiredProtein += (burnedCals * 0.3) / 4;
      requiredFat += (burnedCals * 0.2) / 9;
    }
    
    // 3. Update the remaining calories based on the newly calculated dailyGoal
    eatRemainingCalories = dailyGoalCalories - eatingCalories + burningCalories;
    
    // 4. Emit final state to refresh UI
    updatePetMood();
    emit(ChangeInfoState());
  }

  void updatePetMood({String? customMessage}) {
    if (customMessage != null) {
      currentPetMessage = customMessage;
      emit(ChangeInfoState());
      // Return to mood-based message after 4 seconds
      Timer(const Duration(seconds: 4), () {
        _setMoodMessage();
        emit(ChangeInfoState());
      });
      return;
    }
    _setMoodMessage();
  }

  void _setMoodMessage() {
    // Priority 1: Instant Satisfaction Checks
    if (liters >= waterRequired && waterRequired > 0) {
      currentPetMood = PetMood.refreshed;
    }
    else if (burningCalories > 500) {
      currentPetMood = PetMood.proud;
    }
    // Priority 2: Physical Needs (Thirst/Hunger)
    else if (liters < 0.25) { // Only thirsty if zero glasses drunk today
      currentPetMood = PetMood.thirsty;
    } 
    else if (eatingCalories < dailyGoalCalories * 0.15) { // Only hungry if barely eaten anything
      currentPetMood = PetMood.hungry;
    }
    // Priority 3: Limit Checks
    else if (eatingCalories > dailyGoalCalories + 300) {
      currentPetMood = PetMood.full;
    }
    // Priority 4: Activity check
    else if (burningCalories == 0 && DateTime.now().hour > 14) { // Only lazy after 2 PM
      currentPetMood = PetMood.lazy;
    }
    // Default
    else {
      currentPetMood = PetMood.happy;
    }
    
    currentPetMessage = null;
  }

  void calculateMain() async {
    await calculateBmr();
    emit(ChangeInfoState());
  }

  bool isDark = true;
  IconData darkModeIcon = Icons.track_changes;

  void changeDarkMode({bool? fromShared}) async {
    if (fromShared != null) {
      isDark = fromShared;
    }
    else {
      isDark = !isDark;
      await CacheHelper.putData(key: 'isDark', value: isDark);
    }
    darkModeIcon = isDark ? Icons.light_mode : Icons.dark_mode;
    emit(ChangeDarkModeState());
  }

  Future<void> changeLanguage() async {
    if (language == 'en') {
      language = 'ar';
    } else {
      language = 'en';
    }
    await CacheHelper.putData(key: 'language', value: language);
    emit(ChangeLanguageState());
  }

  Future<void> setLanguage(String langCode) async {
    language = langCode;
    await CacheHelper.putData(key: 'language', value: language);
    emit(ChangeLanguageState());
  }
}
