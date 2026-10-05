import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global_methods.dart';
import '../../../../global/widgets/default_button.dart';
import '../../../../global/widgets/default_text_form_field.dart';
import '../../domain/entities/meal.dart';
import '../bloc/MealsCubit/MealsCubit.dart';

void addNewMealSheet(BuildContext context) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nameArController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController fatController = TextEditingController();
  final TextEditingController carbController = TextEditingController();
  final TextEditingController portionWeightController = TextEditingController(text: '100');
  final TextEditingController portionNameController = TextEditingController(text: isArabic() ? '1 حصة' : '1 Portion');

  bool isDark = Theme.of(context).brightness == Brightness.dark;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                isArabic() ? "إضافة عنصر غذائي جديد" : "Add Standalone Food Item",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                isArabic() 
                  ? "أدخل القيم الغذائية لكل 100 جرام للضمان الدقة."
                  : "Enter nutritional values per 100g for maximum accuracy.",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              DefaultFormField(
                controller: nameController,
                labelText: '${S.of(context).mealName} (EN)',
                hintText: 'e.g. Protein Bar',
                validator: (value) => validatorMethod(value, context),
              ),
              const SizedBox(height: 10),
              DefaultFormField(
                controller: nameArController,
                labelText: '${S.of(context).mealName} (AR)',
                hintText: 'مثال: لوح بروتين',
                validator: (value) => validatorMethod(value, context),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: DefaultFormField(
                      textInputType: TextInputType.number,
                      controller: caloriesController,
                      labelText: "${S.of(context).calories} (per 100g)",
                      hintText: S.of(context).kcal,
                      validator: (value) => validatorMethod(value, context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DefaultFormField(
                      textInputType: TextInputType.number,
                      controller: proteinController,
                      labelText: "${S.of(context).protein} (g per 100g)",
                      hintText: S.of(context).g,
                      validator: (value) => validatorMethod(value, context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: DefaultFormField(
                      textInputType: TextInputType.number,
                      controller: fatController,
                      labelText: "${S.of(context).fat} (g per 100g)",
                      hintText: S.of(context).g,
                      validator: (value) => validatorMethod(value, context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DefaultFormField(
                      textInputType: TextInputType.number,
                      controller: carbController,
                      labelText: "${S.of(context).carb} (g per 100g)",
                      hintText: S.of(context).g,
                      validator: (value) => validatorMethod(value, context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: DefaultFormField(
                      textInputType: TextInputType.number,
                      controller: portionWeightController,
                      labelText: isArabic() ? "وزن الحصة (جرام)" : "Portion Weight (g)",
                      hintText: '100',
                      validator: (value) => validatorMethod(value, context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DefaultFormField(
                      controller: portionNameController,
                      labelText: isArabic() ? "اسم الحصة" : "Portion Name",
                      hintText: 'e.g. 1 Bar',
                      validator: (value) => validatorMethod(value, context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: DefaultButton(
                      textBtn: S.of(context).cancel,
                      color: isDark ? Colors.white10 : Colors.grey[200],
                      textStyle: TextStyle(color: isDark ? Colors.white : Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: DefaultButton(
                      textBtn: S.of(context).confirm,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          MealsCubit.get(context).addMeal(Meal(
                            protein: double.parse(proteinController.text),
                            fat: double.parse(fatController.text),
                            carb: double.parse(carbController.text),
                            calories: double.parse(caloriesController.text),
                            name: nameController.text,
                            nameAr: nameArController.text,
                            defaultValue: double.tryParse(portionWeightController.text) ?? 100,
                            defaultValueName: portionNameController.text,
                          ));
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
