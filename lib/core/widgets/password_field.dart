import 'package:exam_app/core/values/app_assets.dart';
import 'package:exam_app/core/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../validations/validations.dart';
import '../values/app_strings.dart';
import '../values/input_formatters.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool enabled;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final String? labelText;
  final FocusNode? focusNode;
  final String? hintText;
  final Widget? suffixIcon;
  final bool readOnly;

  const PasswordField({
    super.key,
    required this.controller,
    this.validator,
    this.enabled = true,
    this.readOnly = false,
    this.textInputAction,
    this.onFieldSubmitted,
    this.labelText,
    this.focusNode,
    this.hintText,
    this.suffixIcon,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      obscuringCharacter: '*',
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      inputFormatters: AppInputFormatters.strongPassword,
      validator: widget.validator ?? Validations.validateLoginPassword,
      onFieldSubmitted: widget.onFieldSubmitted,
      autofillHints: const [AutofillHints.password],
      style: _obscureText
          ? const TextStyle(letterSpacing: 2, color: AppColors.darkGray)
          : null,
      decoration: InputDecoration(
        labelText: widget.labelText ?? AppStrings.password,
        hintText: widget.hintText ?? AppStrings.enterYouPassword,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.suffixIcon != null) widget.suffixIcon!,
              IconButton(
                onPressed: _toggleVisibility,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: SvgPicture.asset(
                  _obscureText ? AppAssets.visibilityOff : AppAssets.visibilityOn,
                  width: 24.r,
                  height: 24.r,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
