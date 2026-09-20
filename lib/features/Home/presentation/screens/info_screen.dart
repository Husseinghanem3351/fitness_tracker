import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global.dart';
import '../../../../global/global_methods.dart';
import '../../../../global/widgets/default_button.dart';
import '../../../../global/widgets/default_text_form_field.dart';
import '../../data/cache helper.dart';
import '../../data/model.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'home.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? selectedGender;
  String? selectedGoal;
  String? selectedActiveLevel;
  String? selectedDiet; // Added

  @override
  void initState() {
    super.initState();
    if (personalInfo != null) {
      nameController.text = personalInfo!.name;
      ageController.text = personalInfo!.age.round().toString();
      heightController.text = personalInfo!.height.round().toString();
      weightController.text = personalInfo!.weight.round().toString();
    }
    _loadStoredPreferences();
  }

  void _loadStoredPreferences() {
    selectedGoal = CacheHelper.getData(key: 'goal');
    selectedActiveLevel = CacheHelper.getData(key: 'activityLevel');
    selectedDiet = CacheHelper.getData(key: 'dietType');
  }

  @override
  Widget build(BuildContext context) {
    List<String> genders = [S.of(context).male, S.of(context).female];
    List<String> goals = [
      S.of(context).losingWeight,
      S.of(context).gainWeight,
      S.of(context).maintainWeight,
      S.of(context).buildMuscle
    ];
    List<String> activeLevelList = [
      S.of(context).sedentary,
      S.of(context).lightlyActive,
      S.of(context).moderatelyActive,
      S.of(context).veryActive,
      S.of(context).extraActive
    ];
    List<String> activeLevelDescription = [
      S.of(context).workDeskJob,
      S.of(context).longWalksOrEngageInExercise,
      S.of(context).workout3To5InWeek,
      S.of(context).sportMostDays,
      S.of(context).workout6To7withPhysicalActivity
    ];
    List<String> diets = ['Standard', 'Vegetarian', 'Vegan'];

    if (selectedGender == null) {
      if (personalInfo?.gender == 'Male') {
        selectedGender = S.of(context).male;
      } else if (personalInfo?.gender == 'Female') {
        selectedGender = S.of(context).female;
      } else {
        selectedGender = genders[0];
      }
    }
    
    // Ensure selectedGoal and selectedActiveLevel are valid or default
    if (selectedGoal == null || !goals.contains(selectedGoal)) {
      selectedGoal = goals[2]; // Default to maintain weight
    }
    
    if (selectedActiveLevel == null || !activeLevelList.contains(selectedActiveLevel)) {
      selectedActiveLevel = activeLevelList[0];
    }

    if (selectedDiet == null || !diets.contains(selectedDiet)) {
      selectedDiet = personalInfo?.dietType ?? diets[0];
    }

    // Theme logic: Always use light theme colors for this screen if requested
    Color bgColor = Colors.white; // Always white background as requested
    Color textColor = Colors.indigo[900]!;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          S.of(context).personalInfo, 
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Theme(
            // Force Light Mode theme for inputs on this screen
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultFormField(
                      controller: nameController,
                      labelText: S.of(context).name,
                      hintText: S.of(context).name,
                      prefix: const Icon(Icons.person_outline, color: Colors.indigo),
                      validator: (value) => validatorMethod(value, context),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultFormField(
                            controller: ageController,
                            labelText: S.of(context).age,
                            hintText: S.of(context).years,
                            textInputType: TextInputType.number,
                            prefix: const Icon(Icons.calendar_today_outlined, color: Colors.indigo),
                            validator: (value) => validatorMethod(value, context),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildDropdown(
                            context,
                            label: S.of(context).male, // Using gender as label here for context, though 'Gender' was hardcoded
                            value: selectedGender!,
                            items: genders,
                            onChanged: (val) {
                              setState(() {
                                selectedGender = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultFormField(
                            controller: heightController,
                            labelText: S.of(context).height,
                            hintText: S.of(context).cm,
                            textInputType: TextInputType.number,
                            prefix: const Icon(Icons.height, color: Colors.indigo),
                            validator: (value) => validatorMethod(value, context),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: DefaultFormField(
                            controller: weightController,
                            labelText: S.of(context).weight,
                            hintText: S.of(context).kg,
                            textInputType: TextInputType.number,
                            prefix: const Icon(Icons.monitor_weight_outlined, color: Colors.indigo),
                            validator: (value) => validatorMethod(value, context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildDropdown(
                      context,
                      label: S.of(context).yourGoal,
                      value: selectedGoal!,
                      items: goals,
                      onChanged: (val) {
                        setState(() {
                          selectedGoal = val;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildDropdown(
                      context,
                      label: S.of(context).activeLevel,
                      value: selectedActiveLevel!,
                      items: activeLevelList,
                      onChanged: (val) {
                        setState(() {
                          selectedActiveLevel = val;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.indigo.withValues(alpha: 0.1)),
                      ),
                      child: Text(
                        activeLevelDescription[activeLevelList.indexOf(selectedActiveLevel!)],
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.indigo[700],
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildDropdown(
                      context,
                      label: S.of(context).dietaryPreference,
                      value: selectedDiet!,
                      items: diets,
                      onChanged: (val) {
                        setState(() {
                          selectedDiet = val;
                        });
                      },
                      itemLabels: {
                        'Standard': S.of(context).standard,
                        'Vegetarian': S.of(context).vegetarian,
                        'Vegan': S.of(context).vegan,
                      },
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: DefaultButton(
                        textBtn: S.of(context).save,
                        color: Colors.indigo,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            PersonalInfoModel model = PersonalInfoModel(
                              height: double.parse(heightController.text),
                              weight: double.parse(weightController.text),
                              age: double.parse(ageController.text),
                              gender: selectedGender == S.of(context).male ? 'Male' : 'Female',
                              name: nameController.text,
                              dietType: selectedDiet!,
                            );
                            await CacheHelper.putData(key: 'personalInfo', value: jsonEncode(model.toJson()));
                            await CacheHelper.putData(key: 'goal', value: selectedGoal);
                            await CacheHelper.putData(key: 'activityLevel', value: selectedActiveLevel);
                            await CacheHelper.putData(key: 'dietType', value: selectedDiet);
                            
                            if (context.mounted) {
                              HomeCubit.get(context).calculateMain();
                              navigateAndFinish(context, const Home());
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    BuildContext context, {
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
    Map<String, String>? itemLabels, // Added
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
              fontSize: 13,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: value,
              items: items
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(itemLabels?[e] ?? e, style: const TextStyle(color: Colors.black87)),
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
