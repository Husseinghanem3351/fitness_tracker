import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../../global/global_methods.dart';
import '../../../../global/widgets/default_button.dart';
import '../../../../global/widgets/default_text_form_field.dart';
import '../../domain/entities/activity.dart';
import '../bloc/ActivitiesBloc/cubit.dart';

void addNewActivitySheet(BuildContext context) {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController nameArController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController titleArController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

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
          physics: const BouncingScrollPhysics(),
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
                S.of(context).customActivity,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              DefaultFormField(
                controller: titleController,
                labelText: '${S.of(context).category} (EN)',
                hintText: S.of(context).exampleGym,
                validator: (value) => validatorMethod(value, context),
              ),
              DefaultFormField(
                controller: titleArController,
                labelText: '${S.of(context).category} (AR)',
                hintText: S.of(context).exampleGym,
                validator: (value) => validatorMethod(value, context),
              ),
              DefaultFormField(
                controller: nameController,
                labelText: '${S.of(context).activityName} (EN)',
                hintText: S.of(context).exampleSwimming,
                validator: (value) => validatorMethod(value, context),
              ),
              DefaultFormField(
                controller: nameArController,
                labelText: '${S.of(context).activityName} (AR)',
                hintText: S.of(context).exampleSwimming,
                validator: (value) => validatorMethod(value, context),
              ),
              DefaultFormField(
                controller: caloriesController,
                labelText: S.of(context).caloriesPerHour,
                hintText: S.of(context).kcalPerHour,
                textInputType: TextInputType.number,
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
                    child: DefaultButton(
                      textBtn: S.of(context).confirm,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ActivitiesCubit.get(context).addActivity(
                            Activity(
                              name: nameController.text,
                              nameAr: nameArController.text,
                              MES: double.parse(caloriesController.text),
                              title: titleController.text,
                              titleAr: titleArController.text,
                            ),
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
