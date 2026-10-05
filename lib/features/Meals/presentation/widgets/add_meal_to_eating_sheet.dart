import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global_methods.dart';
import '../../../../global/widgets/default_button.dart';
import '../../../../global/widgets/default_text_form_field.dart';
import '../../../../global/widgets/show_toast.dart';
import '../../../Details/domain/entities/eating.dart';
import '../../../Details/presentation/bloc/cubit.dart';
import '../../../Details/presentation/bloc/states.dart';
import '../../domain/entities/meal.dart';

void addMealToEatingSheet(BuildContext context, {required Meal meal}) {
  TextEditingController quantityController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: StatefulBuilder(
        builder: (context, setState) => Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  isArabic() ? meal.nameAr : meal.name,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${meal.calories.round()} ${S.of(context).cal} / 100${S.of(context).g}',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                DefaultFormField(
                  controller: quantityController,
                  labelText: S.of(context).quantity,
                  hintText: S.of(context).g,
                  textInputType: TextInputType.number,
                  prefix: const Icon(Icons.scale_outlined),
                  validator: (value) => validatorMethod(value, context),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: DefaultButton(
                        textBtn: S.of(context).cancel,
                        color: Colors.grey.withOpacity(.1),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: BlocConsumer<DetailsCubit, DetailsStates>(
                        builder: (detailsContext, state) {
                          return DefaultButton(
                            textBtn: S.of(context).add,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                double quantity = double.parse(quantityController.text);
                                DetailsCubit.get(detailsContext).addToEatingCalories(
                                  Eating(
                                    date: DateTime.now(),
                                    quantity: quantity,
                                    calories: meal.calories * quantity / 100,
                                    protein: meal.protein * quantity / 100,
                                    carb: meal.carb * quantity / 100,
                                    mealName: isArabic() ? meal.nameAr : meal.name,
                                    fat: meal.fat * quantity / 100,
                                  ),
                                  context,
                                );
                                Navigator.pop(context);
                              }
                            },
                          );
                        },
                        listener: (detailsContext, state) {
                          if (state is SuccessAddDetailsState) {
                            showToast(context: context, msg: state.message, color: Colors.green);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
