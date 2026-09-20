import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global_methods.dart';
import '../../../../global/widgets/show_toast.dart';
import '../../../../global/widgets/default_text_form_field.dart';
import '../../../../global/widgets/default_button.dart';
import '../../../Details/domain/entities/burning.dart';
import '../../../Details/presentation/bloc/cubit.dart';
import '../../domain/entities/activity.dart';
import '../bloc/ActivitiesBloc/cubit.dart';
import '../bloc/ActivitiesBloc/states.dart';
import '../widgets/ListOfActivities.dart';
import '../../../../features/Home/presentation/cubit/cubit.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    bool isDark = HomeCubit.get(context).isDark;
    Color primaryColor = isDark ? Colors.indigoAccent[100]! : Colors.blueGrey[800]!;
    Color appBarColor = isDark ? const Color(0xFF0B0E11) : Colors.white;

    return ScaffoldMessenger(
      child: Scaffold(
        backgroundColor: appBarColor,
        appBar: AppBar(
          title: Text(S.of(context).activities, style: TextStyle(color: isDark ? Colors.white : primaryColor, fontWeight: FontWeight.bold)),
          backgroundColor: appBarColor,
          elevation: 2,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_sharp, color: primaryColor),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Future.delayed(const Duration(milliseconds: 200)).then((value) {
                  if (context.mounted) Navigator.pop(context);
                });
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: BlocConsumer<ActivitiesCubit, ActivitiesStates>(
            builder: (context, state) {
              if (state is LoadingGetActivitiesState) {
                return Center(child: CircularProgressIndicator(color: primaryColor));
              }
              return Column(
                children: [
                  DefaultFormField(
                    controller: searchController,
                    textInputType: TextInputType.text,
                    prefix: Icon(Icons.search, color: primaryColor),
                    onFieldSubmitted: (value) {
                      ActivitiesCubit.get(context)
                          .searchActivity(searchController.text);
                    },
                    onChanged: (value) {
                      if (value.isEmpty) {
                        ActivitiesCubit.get(context)
                            .searchActivity(searchController.text);
                      }
                    },
                    textInputAction: TextInputAction.search,
                    hintText: S.of(context).search,
                  ),
                  Expanded(child: buildBody(context)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () => _showManualActivitySheet(context),
                      icon: const Icon(Icons.add),
                      label: Text(S.of(context).logManualActivity),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
            listener: (BuildContext context, ActivitiesStates state) {
              if (state is ErrorGetActivitiesState) {
                showToast(
                    context: context, msg: state.error, color: Colors.red);
              } else if (state is SuccessGetActivitiesState) {
                ActivitiesCubit.get(context).activities = state.activities;
              } else if (state is SuccessAddActivityState) {
                showToast(
                    context: context, msg: state.message, color: Colors.green);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    List<Activity> activities = ActivitiesCubit.get(context).activities;
    if (activities.isNotEmpty) {
      return ListOfActivities(
        activities: activities,
      );
    } else {
      return Center(child: Text(S.of(context).noActivitiesFound, style: const TextStyle(color: Colors.blueGrey)));
    }
  }

  void _showManualActivitySheet(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController calController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
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
                const SizedBox(height: 20),
                Text(
                  S.of(context).logManualActivity,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                DefaultFormField(
                  controller: nameController,
                  labelText: S.of(context).activityName,
                  hintText: isArabic() ? "مثال: جري صباحي" : "e.g. Morning Run",
                  validator: (value) => validatorMethod(value, context),
                ),
                DefaultFormField(
                  controller: calController,
                  labelText: S.of(context).totalCaloriesBurned,
                  hintText: S.of(context).cal,
                  textInputType: TextInputType.number,
                  validator: (value) => validatorMethod(value, context),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: DefaultButton(
                        textBtn: S.of(context).cancel,
                        color: Colors.grey.withValues(alpha: .1),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: DefaultButton(
                        textBtn: S.of(context).add,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final double calories = double.tryParse(calController.text) ?? 0;
                            DetailsCubit.get(context).addToBurningCalories(
                              Burning(
                                activityName: nameController.text,
                                calories: calories,
                                date: DateTime.now(),
                                duration: 0, // Manual entry might not have duration
                              ),
                              context,
                            );
                            Navigator.pop(context);
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
    );
  }
}
