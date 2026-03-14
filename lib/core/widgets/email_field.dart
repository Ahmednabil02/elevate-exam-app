import 'package:flutter/material.dart';
import '../validations/validations.dart';
import '../values/app_strings.dart';
import '../values/input_formatters.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool enabled;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  final String? labelText;
  final String? hintText;

  const EmailField({
    super.key,
    required this.controller,
    this.validator,
    this.enabled = true,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.labelText,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction ?? TextInputAction.next,
      inputFormatters: AppInputFormatters.email,
      validator: validator ?? Validations.validateEmail,
      onFieldSubmitted: onFieldSubmitted,
      autofillHints: const [AutofillHints.email],
      decoration: InputDecoration(
        labelText: labelText ?? AppStrings.email,
        hintText: hintText ?? AppStrings.enterYourEmail,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
