import 'package:exam_app/core/values/app_assets.dart';
import 'package:exam_app/core/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      obscuringCharacter: '★',
      textInputAction: textInputAction ?? TextInputAction.done,
      inputFormatters: AppInputFormatters.strongPassword,
      validator: validator ?? Validations.validateLoginPassword,
      onFieldSubmitted: onFieldSubmitted,
      autofillHints: const [AutofillHints.password],
      style: obscureText
          ? const TextStyle(letterSpacing: 2, color: AppColors.darkGray)
          : null,
      decoration: InputDecoration(
        labelText: labelText ?? AppStrings.password,
        suffixIcon:
            suffixIcon ??
            InkWell(
              onTap: toggleVisibility,
              child: SvgPicture.asset(
                obscureText ? AppAssets.visibilityOff : AppAssets.visibilityOn,
                width: 24,
                height: 24,
                fit: BoxFit.scaleDown,
              ),
            ),
      ),
    );
  }
}
