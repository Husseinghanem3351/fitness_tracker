import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global_methods.dart';
import '../../../../global/widgets/default_button.dart';
import '../../../../global/widgets/default_text_form_field.dart';
import '../../domain/entities/meal.dart';
import '../bloc/MealsCubit/MealsCubit.dart';

class SaveCustomMeal extends StatefulWidget {
  const SaveCustomMeal({super.key, required this.meals});

  final List<Meal> meals;

  @override
  State<SaveCustomMeal> createState() => _SaveCustomMealState();
}

class _SaveCustomMealState extends State<SaveCustomMeal> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nameArController = TextEditingController();
  late List<TextEditingController> controllers;

  double totalCalories = 0;
  double totalProtein = 0;
  double totalCarbs = 0;
  double totalFat = 0;
  double totalGrams = 0;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      widget.meals.length,
      (index) => TextEditingController(text: '100'),
    );
    _calculateRunningTotals();
    
    // Add listeners to update UI instantly when quantities change
    for (var controller in controllers) {
      controller.addListener(_calculateRunningTotals);
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    nameController.dispose();
    nameArController.dispose();
    super.dispose();
  }

  void _calculateRunningTotals() {
    double runningCals = 0;
    double runningProtein = 0;
    double runningCarbs = 0;
    double runningFat = 0;
    double runningGrams = 0;

    for (int i = 0; i < widget.meals.length; i++) {
      double grams = double.tryParse(controllers[i].text) ?? 0;
      runningGrams += grams;
      runningCals += (widget.meals[i].calories * grams / 100);
      runningProtein += (widget.meals[i].protein * grams / 100);
      runningCarbs += (widget.meals[i].carb * grams / 100);
      runningFat += (widget.meals[i].fat * grams / 100);
    }

    setState(() {
      totalCalories = runningCals;
      totalProtein = runningProtein;
      totalCarbs = runningCarbs;
      totalFat = runningFat;
      totalGrams = runningGrams;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color primaryColor = isDark ? Colors.indigoAccent[100]! : Colors.indigo[800]!;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0B0E11) : Colors.blueGrey[50],
      appBar: AppBar(
        title: Text(isArabic() ? "تخصيص الوصفة" : "Finalize Recipe"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            // Preview Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Text(
                    "${totalCalories.round()} kcal",
                    style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    isArabic() ? "إجمالي السعرات لـ ${totalGrams.round()}غ" : "Total Calories for ${totalGrams.round()}g",
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMacroPreview(S.of(context).protein, totalProtein),
                      _buildMacroPreview(S.of(context).carb, totalCarbs),
                      _buildMacroPreview(S.of(context).fat, totalFat),
                    ],
                  )
                ],
              ),
            ),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    S.of(context).details,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 12),
                  DefaultFormField(
                    controller: nameController,
                    labelText: '${S.of(context).mealName} (EN)',
                    validator: (value) => validatorMethod(value, context),
                  ),
                  const SizedBox(height: 10),
                  DefaultFormField(
                    controller: nameArController,
                    labelText: '${S.of(context).mealName} (AR)',
                    validator: (value) => validatorMethod(value, context),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    isArabic() ? "المكونات والأوزان" : "Ingredients & Weights",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(widget.meals.length, (index) {
                    final meal = widget.meals[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              isArabic() ? meal.nameAr : meal.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 15),
                          SizedBox(
                            width: 100,
                            child: DefaultFormField(
                              controller: controllers[index],
                              textInputType: TextInputType.number,
                              labelText: S.of(context).g,
                              validator: (value) => validatorMethod(value, context),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DefaultButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Meal finalMeal = _assembleFinalMeal();
                    MealsCubit.get(context).addMeal(finalMeal);
                    Navigator.pop(context); // Pop Save screen
                    Navigator.pop(context); // Pop Selection screen
                  }
                },
                textBtn: S.of(context).save,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroPreview(String label, double value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
        Text("${value.round()}g", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Meal _assembleFinalMeal() {
    // Calculate per 100g for the final entry
    double gramsFactor = totalGrams > 0 ? (100 / totalGrams) : 0;
    
    return Meal(
      name: nameController.text,
      nameAr: nameArController.text,
      calories: totalCalories * gramsFactor,
      protein: totalProtein * gramsFactor,
      carb: totalCarbs * gramsFactor,
      fat: totalFat * gramsFactor,
    );
  }
}
