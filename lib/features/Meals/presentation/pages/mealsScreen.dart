import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global_methods.dart';
import '../../../../global/widgets/show_toast.dart';
import '../../../../global/widgets/default_text_form_field.dart';
import '../../domain/entities/meal.dart';
import '../bloc/MealsCubit/MealsCubit.dart';
import '../bloc/MealsCubit/MealsStates.dart';
import '../widgets/ListOfMeals.dart';
import 'customMeals.dart';
import '../../../../features/Home/presentation/cubit/cubit.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    bool isDark = HomeCubit.get(context).isDark;
    Color primaryColor = isDark ? Colors.indigoAccent[100]! : Colors.blue[800]!;
    Color appBarColor = isDark ? const Color(0xFF0B0E11) : Colors.white;

    return ScaffoldMessenger(
      child: Scaffold(
        backgroundColor: appBarColor,
        appBar: AppBar(
          title: Text(S.of(context).meals, style: TextStyle(color: isDark ? Colors.white : primaryColor, fontWeight: FontWeight.bold)),
          backgroundColor: appBarColor,
          elevation: 2,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp, color: isDark ? Colors.indigoAccent[100] : primaryColor),
            onPressed: () {
              FocusScope.of(context).unfocus();
              Future.delayed(const Duration(milliseconds: 200)).then((value) {
                if (context.mounted) Navigator.pop(context);
              });
            },
          ),
        ),
        body: BlocConsumer<MealsCubit, MealsStates>(
          builder: (context, state) {
            if (state is GetMealsLoadingState) {
              return Center(child: CircularProgressIndicator(color: primaryColor));
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  DefaultFormField(
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    prefix: Icon(Icons.search, color: isDark ? Colors.indigoAccent[100] : primaryColor),
                    onFieldSubmitted: (value) {
                      MealsCubit.get(context).searchMeal(searchController.text);
                    },
                    onChanged: (value) {
                      if (value.isEmpty) {
                        MealsCubit.get(context)
                            .searchMeal(searchController.text);
                      }
                    },
                    hintText: S.of(context).search,
                  ),
                  Expanded(child: buildBody(context)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        navigateTo(
                          context,
                          const CustomMeal(),
                        );
                      },
                      icon: const Icon(Icons.restaurant_menu),
                      label: Text(S.of(context).customMeal),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: isDark ? Colors.black : Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
          listener: (context, state) {
            if (state is GetMealsErrorState) {
              showToast(context: context, msg: state.error, color: Colors.red);
            } else if (state is GetMealsSuccessState) {
              MealsCubit.get(context).meals = state.meals.$1;
              MealsCubit.get(context).basicMeals = state.meals.$2;
            } else if (state is AddMealsSuccessState) {
              showToast(
                  context: context, msg: state.message, color: Colors.green);
            }
          },
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    List<Meal> meals = MealsCubit.get(context).meals;
    List<Meal> basicMeals = MealsCubit.get(context).basicMeals;
    if (meals.isNotEmpty || basicMeals.isNotEmpty) {
      return ListOfMeals(
        meals: meals,
        basicMeals: basicMeals,
      );
    } else {
      return Center(child: Text(S.of(context).noMealsFound, style: const TextStyle(color: Colors.blueGrey)));
    }
  }
}
