import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import 'default_button.dart';

void deleteDialog({required context,required String message,required void Function()? onPressed}){
  showDialog(context: context, builder: (context) => AlertDialog(
    content: Text(message),
    actions: [
      DefaultButton(
        onPressed: onPressed,
        textBtn: S.of(context).confirm,
      ),
      DefaultButton(
        onPressed: (){
          Navigator.of(context).pop(false);
        },
        textBtn: S.of(context).cancel,
      )
    ],
  ),);
}