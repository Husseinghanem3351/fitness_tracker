// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `remaining`
  String get remaining {
    return Intl.message(
      'remaining',
      name: 'remaining',
      desc: '',
      args: [],
    );
  }

  /// `fat`
  String get fat {
    return Intl.message(
      'fat',
      name: 'fat',
      desc: '',
      args: [],
    );
  }

  /// `carb`
  String get carb {
    return Intl.message(
      'carb',
      name: 'carb',
      desc: '',
      args: [],
    );
  }

  /// `protein`
  String get protein {
    return Intl.message(
      'protein',
      name: 'protein',
      desc: '',
      args: [],
    );
  }

  /// `cal`
  String get cal {
    return Intl.message(
      'cal',
      name: 'cal',
      desc: '',
      args: [],
    );
  }

  /// `Eaten`
  String get eaten {
    return Intl.message(
      'Eaten',
      name: 'eaten',
      desc: '',
      args: [],
    );
  }

  /// `Burned`
  String get burned {
    return Intl.message(
      'Burned',
      name: 'burned',
      desc: '',
      args: [],
    );
  }

  /// `liter`
  String get liter {
    return Intl.message(
      'liter',
      name: 'liter',
      desc: '',
      args: [],
    );
  }

  /// `Goal`
  String get goal {
    return Intl.message(
      'Goal',
      name: 'goal',
      desc: '',
      args: [],
    );
  }

  /// `details`
  String get details {
    return Intl.message(
      'details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `your goal`
  String get yourGoal {
    return Intl.message(
      'your goal',
      name: 'yourGoal',
      desc: '',
      args: [],
    );
  }

  /// `Water Tracker`
  String get waterTracker {
    return Intl.message(
      'Water Tracker',
      name: 'waterTracker',
      desc: '',
      args: [],
    );
  }

  /// `lose weight`
  String get losingWeight {
    return Intl.message(
      'lose weight',
      name: 'losingWeight',
      desc: '',
      args: [],
    );
  }

  /// `gain weight`
  String get gainWeight {
    return Intl.message(
      'gain weight',
      name: 'gainWeight',
      desc: '',
      args: [],
    );
  }

  /// `maintain weight`
  String get maintainWeight {
    return Intl.message(
      'maintain weight',
      name: 'maintainWeight',
      desc: '',
      args: [],
    );
  }

  /// `build muscle`
  String get buildMuscle {
    return Intl.message(
      'build muscle',
      name: 'buildMuscle',
      desc: '',
      args: [],
    );
  }

  /// `your active level`
  String get activeLevel {
    return Intl.message(
      'your active level',
      name: 'activeLevel',
      desc: '',
      args: [],
    );
  }

  /// `People who work desk jobs and engage in very little exercise or chores`
  String get workDeskJob {
    return Intl.message(
      'People who work desk jobs and engage in very little exercise or chores',
      name: 'workDeskJob',
      desc: '',
      args: [],
    );
  }

  /// `People who do chores and go on long walks/engage in exercise at least 1 to 3 days in a week`
  String get longWalksOrEngageInExercise {
    return Intl.message(
      'People who do chores and go on long walks/engage in exercise at least 1 to 3 days in a week',
      name: 'longWalksOrEngageInExercise',
      desc: '',
      args: [],
    );
  }

  /// `People who move a lot during the day and workout (moderate effort) at least 3 to 5 days in a week`
  String get workout3To5InWeek {
    return Intl.message(
      'People who move a lot during the day and workout (moderate effort) at least 3 to 5 days in a week',
      name: 'workout3To5InWeek',
      desc: '',
      args: [],
    );
  }

  /// `People who play sports or engage in vigorous exercise on most days`
  String get sportMostDays {
    return Intl.message(
      'People who play sports or engage in vigorous exercise on most days',
      name: 'sportMostDays',
      desc: '',
      args: [],
    );
  }

  /// `People who do intense workouts 6 to 7 days a week with work that demands physical activity`
  String get workout6To7withPhysicalActivity {
    return Intl.message(
      'People who do intense workouts 6 to 7 days a week with work that demands physical activity',
      name: 'workout6To7withPhysicalActivity',
      desc: '',
      args: [],
    );
  }

  /// `Sedentary`
  String get sedentary {
    return Intl.message(
      'Sedentary',
      name: 'sedentary',
      desc: '',
      args: [],
    );
  }

  /// `lightly Active`
  String get lightlyActive {
    return Intl.message(
      'lightly Active',
      name: 'lightlyActive',
      desc: '',
      args: [],
    );
  }

  /// `Moderately Active`
  String get moderatelyActive {
    return Intl.message(
      'Moderately Active',
      name: 'moderatelyActive',
      desc: '',
      args: [],
    );
  }

  /// `very Active`
  String get veryActive {
    return Intl.message(
      'very Active',
      name: 'veryActive',
      desc: '',
      args: [],
    );
  }

  /// `Extra Active`
  String get extraActive {
    return Intl.message(
      'Extra Active',
      name: 'extraActive',
      desc: '',
      args: [],
    );
  }

  /// `previous`
  String get previous {
    return Intl.message(
      'previous',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `next`
  String get next {
    return Intl.message(
      'next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `save`
  String get save {
    return Intl.message(
      'save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Personal Info`
  String get personalInfo {
    return Intl.message(
      'Personal Info',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get name {
    return Intl.message(
      'name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `age (years)`
  String get age {
    return Intl.message(
      'age (years)',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `height (cm)`
  String get height {
    return Intl.message(
      'height (cm)',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `weight (kg)`
  String get weight {
    return Intl.message(
      'weight (kg)',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `this field is required`
  String get validationMessage {
    return Intl.message(
      'this field is required',
      name: 'validationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `add new meal`
  String get addNewMeal {
    return Intl.message(
      'add new meal',
      name: 'addNewMeal',
      desc: '',
      args: [],
    );
  }

  /// `search`
  String get search {
    return Intl.message(
      'search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `custom Meal`
  String get customMeal {
    return Intl.message(
      'custom Meal',
      name: 'customMeal',
      desc: '',
      args: [],
    );
  }

  /// `description`
  String get description {
    return Intl.message(
      'description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `quantity (g)`
  String get quantity {
    return Intl.message(
      'quantity (g)',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `calories`
  String get calories {
    return Intl.message(
      'calories',
      name: 'calories',
      desc: '',
      args: [],
    );
  }

  /// `g`
  String get g {
    return Intl.message(
      'g',
      name: 'g',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `add`
  String get add {
    return Intl.message(
      'add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `per 100 g`
  String get per100g {
    return Intl.message(
      'per 100 g',
      name: 'per100g',
      desc: '',
      args: [],
    );
  }

  /// `confirm`
  String get confirm {
    return Intl.message(
      'confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `are you sure you want to delete this element`
  String get deleteConfirm {
    return Intl.message(
      'are you sure you want to delete this element',
      name: 'deleteConfirm',
      desc: '',
      args: [],
    );
  }

  /// `last 24 h`
  String get lastDay {
    return Intl.message(
      'last 24 h',
      name: 'lastDay',
      desc: '',
      args: [],
    );
  }

  /// `last week`
  String get lastWeek {
    return Intl.message(
      'last week',
      name: 'lastWeek',
      desc: '',
      args: [],
    );
  }

  /// `statistics`
  String get statistics {
    return Intl.message(
      'statistics',
      name: 'statistics',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `min`
  String get min {
    return Intl.message(
      'min',
      name: 'min',
      desc: '',
      args: [],
    );
  }

  /// `custom Activity`
  String get customActivity {
    return Intl.message(
      'custom Activity',
      name: 'customActivity',
      desc: '',
      args: [],
    );
  }

  /// `activity`
  String get activity {
    return Intl.message(
      'activity',
      name: 'activity',
      desc: '',
      args: [],
    );
  }

  /// `duration (min)`
  String get duration {
    return Intl.message(
      'duration (min)',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `calories per hour`
  String get caloriesPerHour {
    return Intl.message(
      'calories per hour',
      name: 'caloriesPerHour',
      desc: '',
      args: [],
    );
  }

  /// `meals`
  String get meals {
    return Intl.message(
      'meals',
      name: 'meals',
      desc: '',
      args: [],
    );
  }

  /// `activities`
  String get activities {
    return Intl.message(
      'activities',
      name: 'activities',
      desc: '',
      args: [],
    );
  }

  /// `dark mode`
  String get darkMode {
    return Intl.message(
      'dark mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `light mode`
  String get lightMode {
    return Intl.message(
      'light mode',
      name: 'lightMode',
      desc: '',
      args: [],
    );
  }

  /// `arabic`
  String get changeLanguage {
    return Intl.message(
      'arabic',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Daily Budget`
  String get dailyBudget {
    return Intl.message(
      'Daily Budget',
      name: 'dailyBudget',
      desc: '',
      args: [],
    );
  }

  /// `Food`
  String get food {
    return Intl.message(
      'Food',
      name: 'food',
      desc: '',
      args: [],
    );
  }

  /// `Exercise`
  String get exercise {
    return Intl.message(
      'Exercise',
      name: 'exercise',
      desc: '',
      args: [],
    );
  }

  /// `Track Your Calories`
  String get onboardingTitle1 {
    return Intl.message(
      'Track Your Calories',
      name: 'onboardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Keep an eye on your daily intake and maintain a healthy lifestyle with ease.`
  String get onboardingBody1 {
    return Intl.message(
      'Keep an eye on your daily intake and maintain a healthy lifestyle with ease.',
      name: 'onboardingBody1',
      desc: '',
      args: [],
    );
  }

  /// `Monitor Macros`
  String get onboardingTitle2 {
    return Intl.message(
      'Monitor Macros',
      name: 'onboardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Balanced nutrition is key. Track your Protein, Carbs, and Fats dynamically.`
  String get onboardingBody2 {
    return Intl.message(
      'Balanced nutrition is key. Track your Protein, Carbs, and Fats dynamically.',
      name: 'onboardingBody2',
      desc: '',
      args: [],
    );
  }

  /// `Stay Hydrated`
  String get onboardingTitle3 {
    return Intl.message(
      'Stay Hydrated',
      name: 'onboardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Never forget to drink water. We calculate your needs based on your body and activity.`
  String get onboardingBody3 {
    return Intl.message(
      'Never forget to drink water. We calculate your needs based on your body and activity.',
      name: 'onboardingBody3',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Nutrition Guide`
  String get nutritionGuide {
    return Intl.message(
      'Nutrition Guide',
      name: 'nutritionGuide',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Plan`
  String get weeklyPlan {
    return Intl.message(
      'Weekly Plan',
      name: 'weeklyPlan',
      desc: '',
      args: [],
    );
  }

  /// `Discover Meals`
  String get discoverMeals {
    return Intl.message(
      'Discover Meals',
      name: 'discoverMeals',
      desc: '',
      args: [],
    );
  }

  /// `Smart Nutrition Guide`
  String get smartNutritionGuide {
    return Intl.message(
      'Smart Nutrition Guide',
      name: 'smartNutritionGuide',
      desc: '',
      args: [],
    );
  }

  /// `Discover your tailored meal plan`
  String get tailoredMealPlan {
    return Intl.message(
      'Discover your tailored meal plan',
      name: 'tailoredMealPlan',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Meal Plan`
  String get weeklyMealPlan {
    return Intl.message(
      'Weekly Meal Plan',
      name: 'weeklyMealPlan',
      desc: '',
      args: [],
    );
  }

  /// `Dietary Preference`
  String get dietaryPreference {
    return Intl.message(
      'Dietary Preference',
      name: 'dietaryPreference',
      desc: '',
      args: [],
    );
  }

  /// `Standard`
  String get standard {
    return Intl.message(
      'Standard',
      name: 'standard',
      desc: '',
      args: [],
    );
  }

  /// `Vegetarian`
  String get vegetarian {
    return Intl.message(
      'Vegetarian',
      name: 'vegetarian',
      desc: '',
      args: [],
    );
  }

  /// `Vegan`
  String get vegan {
    return Intl.message(
      'Vegan',
      name: 'vegan',
      desc: '',
      args: [],
    );
  }

  /// `Note: These are nutritional suggestions to help you reach your goals. Adjust portions based on your actual hunger and activity.`
  String get disclaimerText {
    return Intl.message(
      'Note: These are nutritional suggestions to help you reach your goals. Adjust portions based on your actual hunger and activity.',
      name: 'disclaimerText',
      desc: '',
      args: [],
    );
  }

  /// `HIGH PERFORMANCE MENU`
  String get highPerformanceMenu {
    return Intl.message(
      'HIGH PERFORMANCE MENU',
      name: 'highPerformanceMenu',
      desc: '',
      args: [],
    );
  }

  /// `Optimized for your goal`
  String get optimizedForGoal {
    return Intl.message(
      'Optimized for your goal',
      name: 'optimizedForGoal',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Search meals...`
  String get searchMeals {
    return Intl.message(
      'Search meals...',
      name: 'searchMeals',
      desc: '',
      args: [],
    );
  }

  /// `Total Calories`
  String get totalCalories {
    return Intl.message(
      'Total Calories',
      name: 'totalCalories',
      desc: '',
      args: [],
    );
  }

  /// `No activities found`
  String get noActivitiesFound {
    return Intl.message(
      'No activities found',
      name: 'noActivitiesFound',
      desc: '',
      args: [],
    );
  }

  /// `No daily history available yet`
  String get noDailyHistory {
    return Intl.message(
      'No daily history available yet',
      name: 'noDailyHistory',
      desc: '',
      args: [],
    );
  }

  /// `SKIP`
  String get skip {
    return Intl.message(
      'SKIP',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Category (EN)`
  String get categoryEn {
    return Intl.message(
      'Category (EN)',
      name: 'categoryEn',
      desc: '',
      args: [],
    );
  }

  /// `Category (AR)`
  String get categoryAr {
    return Intl.message(
      'Category (AR)',
      name: 'categoryAr',
      desc: '',
      args: [],
    );
  }

  /// `Activity Name (EN)`
  String get activityNameEn {
    return Intl.message(
      'Activity Name (EN)',
      name: 'activityNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Activity Name (AR)`
  String get activityNameAr {
    return Intl.message(
      'Activity Name (AR)',
      name: 'activityNameAr',
      desc: '',
      args: [],
    );
  }

  /// `Meal Name (EN)`
  String get mealNameEn {
    return Intl.message(
      'Meal Name (EN)',
      name: 'mealNameEn',
      desc: '',
      args: [],
    );
  }

  /// `Meal Name (AR)`
  String get mealNameAr {
    return Intl.message(
      'Meal Name (AR)',
      name: 'mealNameAr',
      desc: '',
      args: [],
    );
  }

  /// `Weight (g)`
  String get weightG {
    return Intl.message(
      'Weight (g)',
      name: 'weightG',
      desc: '',
      args: [],
    );
  }

  /// `Add to Tracker`
  String get addToTracker {
    return Intl.message(
      'Add to Tracker',
      name: 'addToTracker',
      desc: '',
      args: [],
    );
  }

  /// `Log {mealName}`
  String logMeal(Object mealName) {
    return Intl.message(
      'Log $mealName',
      name: 'logMeal',
      desc: '',
      args: [mealName],
    );
  }

  /// `Log {activityName}`
  String logActivity(Object activityName) {
    return Intl.message(
      'Log $activityName',
      name: 'logActivity',
      desc: '',
      args: [activityName],
    );
  }

  /// `Enter the quantity you consumed (in grams):`
  String get enterQuantity {
    return Intl.message(
      'Enter the quantity you consumed (in grams):',
      name: 'enterQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message(
      'Minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Log {mealType}?`
  String acceptMeal(Object mealType) {
    return Intl.message(
      'Log $mealType?',
      name: 'acceptMeal',
      desc: '',
      args: [mealType],
    );
  }

  /// `This will add {calories} calories to your daily intake.`
  String acceptMealBody(Object calories) {
    return Intl.message(
      'This will add $calories calories to your daily intake.',
      name: 'acceptMealBody',
      desc: '',
      args: [calories],
    );
  }

  /// `Monday`
  String get monday {
    return Intl.message(
      'Monday',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get tuesday {
    return Intl.message(
      'Tuesday',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message(
      'Wednesday',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get thursday {
    return Intl.message(
      'Thursday',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get friday {
    return Intl.message(
      'Friday',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get saturday {
    return Intl.message(
      'Saturday',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get sunday {
    return Intl.message(
      'Sunday',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Language`
  String get chooseLanguage {
    return Intl.message(
      'Choose Your Language',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `اختر لغتك المفضلة`
  String get chooseLanguageAr {
    return Intl.message(
      'اختر لغتك المفضلة',
      name: 'chooseLanguageAr',
      desc: '',
      args: [],
    );
  }

  /// `No history available yet`
  String get noHistory {
    return Intl.message(
      'No history available yet',
      name: 'noHistory',
      desc: '',
      args: [],
    );
  }

  /// `{item} deleted`
  String deleted(Object item) {
    return Intl.message(
      '$item deleted',
      name: 'deleted',
      desc: '',
      args: [item],
    );
  }

  /// `Added successfully`
  String get addedSuccess {
    return Intl.message(
      'Added successfully',
      name: 'addedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Deleted successfully`
  String get deleteSucceed {
    return Intl.message(
      'Deleted successfully',
      name: 'deleteSucceed',
      desc: '',
      args: [],
    );
  }

  /// `Years`
  String get years {
    return Intl.message(
      'Years',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// `cm`
  String get cm {
    return Intl.message(
      'cm',
      name: 'cm',
      desc: '',
      args: [],
    );
  }

  /// `kg`
  String get kg {
    return Intl.message(
      'kg',
      name: 'kg',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Activity Name`
  String get activityName {
    return Intl.message(
      'Activity Name',
      name: 'activityName',
      desc: '',
      args: [],
    );
  }

  /// `Meal Name`
  String get mealName {
    return Intl.message(
      'Meal Name',
      name: 'mealName',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Gym`
  String get exampleGym {
    return Intl.message(
      'e.g. Gym',
      name: 'exampleGym',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Swimming`
  String get exampleSwimming {
    return Intl.message(
      'e.g. Swimming',
      name: 'exampleSwimming',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Grilled Chicken`
  String get exampleChicken {
    return Intl.message(
      'e.g. Grilled Chicken',
      name: 'exampleChicken',
      desc: '',
      args: [],
    );
  }

  /// `kcal`
  String get kcal {
    return Intl.message(
      'kcal',
      name: 'kcal',
      desc: '',
      args: [],
    );
  }

  /// `kcal/h`
  String get kcalPerHour {
    return Intl.message(
      'kcal/h',
      name: 'kcalPerHour',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `No history available yet`
  String get noHistoryAvailable {
    return Intl.message(
      'No history available yet',
      name: 'noHistoryAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No meals found`
  String get noMealsFound {
    return Intl.message(
      'No meals found',
      name: 'noMealsFound',
      desc: '',
      args: [],
    );
  }

  /// `{mealName} ({grams}g) logged!`
  String mealLogged(Object mealName, Object grams) {
    return Intl.message(
      '$mealName ($grams g) logged!',
      name: 'mealLogged',
      desc: '',
      args: [mealName, grams],
    );
  }

  /// `{mealType} logged successfully!`
  String mealTypeLogged(Object mealType) {
    return Intl.message(
      '$mealType logged successfully!',
      name: 'mealTypeLogged',
      desc: '',
      args: [mealType],
    );
  }

  /// `ZELORA`
  String get appName {
    return Intl.message(
      'ZELORA',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Log Manual Activity`
  String get logManualActivity {
    return Intl.message(
      'Log Manual Activity',
      name: 'logManualActivity',
      desc: '',
      args: [],
    );
  }

  /// `Enter total calories burned:`
  String get enterTotalCalories {
    return Intl.message(
      'Enter total calories burned:',
      name: 'enterTotalCalories',
      desc: '',
      args: [],
    );
  }

  /// `Total Calories Burned`
  String get totalCaloriesBurned {
    return Intl.message(
      'Total Calories Burned',
      name: 'totalCaloriesBurned',
      desc: '',
      args: [],
    );
  }

  /// `Suggested Meals`
  String get suggestedMeals {
    return Intl.message(
      'Suggested Meals',
      name: 'suggestedMeals',
      desc: '',
      args: [],
    );
  }

  /// `Breakfast Options`
  String get breakfastOptions {
    return Intl.message(
      'Breakfast Options',
      name: 'breakfastOptions',
      desc: '',
      args: [],
    );
  }

  /// `Lunch Options`
  String get lunchOptions {
    return Intl.message(
      'Lunch Options',
      name: 'lunchOptions',
      desc: '',
      args: [],
    );
  }

  /// `Dinner Options`
  String get dinnerOptions {
    return Intl.message(
      'Dinner Options',
      name: 'dinnerOptions',
      desc: '',
      args: [],
    );
  }

  /// `Snack Options`
  String get snackOptions {
    return Intl.message(
      'Snack Options',
      name: 'snackOptions',
      desc: '',
      args: [],
    );
  }

  /// `Portion`
  String get portion {
    return Intl.message(
      'Portion',
      name: 'portion',
      desc: '',
      args: [],
    );
  }

  /// `Zelo`
  String get petZelo {
    return Intl.message(
      'Zelo',
      name: 'petZelo',
      desc: '',
      args: [],
    );
  }

  /// `I'm Zelo! Let's get fit together!`
  String get petMsgHappy {
    return Intl.message(
      'I\'m Zelo! Let\'s get fit together!',
      name: 'petMsgHappy',
      desc: '',
      args: [],
    );
  }

  /// `I'm thirsty... Can I have some water? 🌵`
  String get petMsgThirsty {
    return Intl.message(
      'I\'m thirsty... Can I have some water? 🌵',
      name: 'petMsgThirsty',
      desc: '',
      args: [],
    );
  }

  /// `Ahh, much better! Keep drinking! 🌊`
  String get petMsgRefreshed {
    return Intl.message(
      'Ahh, much better! Keep drinking! 🌊',
      name: 'petMsgRefreshed',
      desc: '',
      args: [],
    );
  }

  /// `My tummy is growling... snack time? 🍎`
  String get petMsgHungry {
    return Intl.message(
      'My tummy is growling... snack time? 🍎',
      name: 'petMsgHungry',
      desc: '',
      args: [],
    );
  }

  /// `Whew! I'm so full! 😵`
  String get petMsgFull {
    return Intl.message(
      'Whew! I\'m so full! 😵',
      name: 'petMsgFull',
      desc: '',
      args: [],
    );
  }

  /// `Wow! Look at those muscles! 💪`
  String get petMsgProud {
    return Intl.message(
      'Wow! Look at those muscles! 💪',
      name: 'petMsgProud',
      desc: '',
      args: [],
    );
  }

  /// `Is it a rest day? I'm feeling a bit sleepy... 🥺`
  String get petMsgLazy {
    return Intl.message(
      'Is it a rest day? I\'m feeling a bit sleepy... 🥺',
      name: 'petMsgLazy',
      desc: '',
      args: [],
    );
  }

  /// `Show Options`
  String get showOptions {
    return Intl.message(
      'Show Options',
      name: 'showOptions',
      desc: '',
      args: [],
    );
  }

  /// `Hide Options`
  String get hideOptions {
    return Intl.message(
      'Hide Options',
      name: 'hideOptions',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
