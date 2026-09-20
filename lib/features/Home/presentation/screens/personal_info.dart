import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import '../../../../global/global_methods.dart';
import '../../../../global/widgets/default_text_form_field.dart';
import '../widgets/select_gender.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({
    super.key,
    required this.weightController,
    required this.nameController,
    required this.ageController,
    required this.heightController,
  });
  final TextEditingController weightController;
  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController heightController;

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).personalInfo,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            DefaultFormField(
              labelText: S.of(context).name,
              controller: widget.nameController,
              validator: (value) => validatorMethod(value, context),
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            DefaultFormField(
              textInputAction: TextInputAction.next,
              labelText: S.of(context).age,
              controller: widget.ageController,
              validator: (value) => validatorMethod(value, context),
              textInputType: TextInputType.number,
            ),
            DefaultFormField(
              textInputAction: TextInputAction.next,
              controller: widget.weightController,
              labelText: S.of(context).weight,
              validator: (value) => validatorMethod(value, context),
              textInputType: TextInputType.number,
            ),
            DefaultFormField(
              controller: widget.heightController,
              labelText: S.of(context).height,
              validator: (value) => validatorMethod(value, context),
              textInputType: TextInputType.number,
              onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
            ),
            const SelectGender(),
          ],
        ),
      ),
    );
  }
}

extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (FocusScope.of(this).focusedChild?.context?.widget is EditableText);
  }
}
