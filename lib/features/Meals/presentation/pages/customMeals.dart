import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global_methods.dart';
import '../../../../global/widgets/show_toast.dart';
import '../bloc/MealsCubit/MealsCubit.dart';
import '../bloc/MealsCubit/MealsStates.dart';
import '../widgets/CheckBoxTile.dart';
import '../../domain/entities/meal.dart';
import '../widgets/MealElement.dart';
import 'SaveCustomMeal.dart';

class CustomMeal extends StatefulWidget {
  const CustomMeal({super.key});

  @override
  State<CustomMeal> createState() => _CustomMealState();
}

class _CustomMealState extends State<CustomMeal> {
  final List<Meal> selectedIngredients = [];

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color primaryColor = isDark ? Colors.indigoAccent[100]! : Colors.indigo[800]!;

    return ScaffoldMessenger(
      child: Scaffold(
        backgroundColor: isDark ? const Color(0xFF0B0E11) : Colors.blueGrey[50],
        appBar: AppBar(
          title: Text(S.of(context).customMeal, style: const TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            if (selectedIngredients.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton.icon(
                  onPressed: () {
                    navigateTo(
                      context,
                      SaveCustomMeal(
                        meals: List.from(selectedIngredients),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                  label: Text(S.of(context).next, style: const TextStyle(fontWeight: FontWeight.bold)),
                  style: TextButton.styleFrom(
                    foregroundColor: primaryColor,
                    backgroundColor: primaryColor.withValues(alpha: 0.1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              )
          ],
        ),
        body: BlocConsumer<MealsCubit, MealsStates>(
          builder: (context, state) {
            final cubit = MealsCubit.get(context);
            final allMeals = [...cubit.meals, ...cubit.basicMeals];

            if (state is GetMealsLoadingState) {
              return Center(child: CircularProgressIndicator(color: primaryColor));
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.orange.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded, color: Colors.orange, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            isArabic() 
                              ? "اختر المكونات الأساسية لوصفتك، ثم اضغط على 'التالي' لتحديد الكميات." 
                              : "Select the basic ingredients for your recipe, then tap 'Next' to set quantities.",
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final meal = allMeals[index];
                      return CheckBoxElement(
                        checkBoxWidget: MealElement(
                          isAllowDelete: false,
                          meal: meal,
                        ),
                        function: (value) {
                          setState(() {
                            if (value) {
                              selectedIngredients.add(meal);
                            } else {
                              selectedIngredients.remove(meal);
                            }
                          });
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemCount: allMeals.length,
                  ),
                ),
              ],
            );
          },
          listener: (context, state) {
            if (state is GetMealsErrorState) {
              showToast(context: context, msg: state.error, color: Colors.red);
            } else if (state is GetMealsSuccessState) {
              MealsCubit.get(context).meals = state.meals.$1;
              MealsCubit.get(context).basicMeals = state.meals.$2;
            }
          },
        ),
      ),
    );
  }
}
