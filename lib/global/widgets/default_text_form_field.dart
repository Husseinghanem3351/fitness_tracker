import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  final int? maxLines;
  final String? hintText;
  final String? labelText;
  final Text? labelWidget;
  final Text? hintWidget;
  final Widget? prefix;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool isFilled;

  const DefaultFormField({
    super.key,
    this.maxLines = 1,
    this.hintText,
    this.labelText,
    this.labelWidget,
    this.hintWidget,
    this.prefix,
    this.suffix,
    this.validator,
    required this.controller,
    this.onFieldSubmitted,
    this.textInputType,
    this.textInputAction,
    this.onChanged,
    this.isFilled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
              child: Text(
                labelText!,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          TextFormField(
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            keyboardType: textInputType ?? TextInputType.name,
            textInputAction: textInputAction ?? TextInputAction.done,
            controller: controller,
            validator: validator,
            maxLines: maxLines,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5), fontSize: 14),
              suffixIcon: suffix,
              prefixIcon: prefix,
              filled: isFilled,
              fillColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.white.withOpacity(0.05),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.withOpacity(0.1)
                      : Colors.white.withOpacity(0.1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.redAccent, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
