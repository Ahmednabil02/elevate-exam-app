import 'package:exam_app/core/values/app_assets.dart';
import 'package:flutter/material.dart';

import '../../validations/validations.dart';
import '../../values/app_strings.dart';
import '../../values/input_formatters.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool enabled;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final void Function()? toggleVisibility;
  final String? labelText;
  final FocusNode? focusNode;
  final bool obscureText;

  const PasswordField({
    super.key,
    required this.controller,
    this.validator,
    this.enabled = true,
    this.textInputAction,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.labelText,
    this.toggleVisibility,
    this.obscureText = true,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: textInputAction ?? TextInputAction.done,
      inputFormatters: AppInputFormatters.strongPassword,
      validator: validator ?? Validations.validateLoginPassword,
      onFieldSubmitted: onFieldSubmitted,
      autofillHints: const [AutofillHints.password],
      decoration: InputDecoration(
        labelText: labelText ?? AppStrings.password,
        suffixIcon:suffixIcon?? InkWell(
          onTap: toggleVisibility,
          child: Image.asset(
            obscureText
                ? AppAssets.visibilityOff
                : AppAssets.visibilityOn,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
