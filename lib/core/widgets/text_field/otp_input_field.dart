import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../values/app_colors.dart';
import '../../values/app_font_style.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final int length;
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool hasError;

  const OtpInputField({
    super.key,
    required this.controller,
    this.focusNode,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
    this.validator,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: length,
        controller: controller,
        focusNode: focusNode,
        onCompleted: onCompleted,
        onChanged: onChanged,
        validator: validator,
        defaultPinTheme: _defaultPinTheme(context),
        focusedPinTheme: _focusedPinTheme(context),
        submittedPinTheme: _submittedPinTheme(context),
        errorPinTheme: _errorPinTheme(context),
        pinAnimationType: PinAnimationType.fade,
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        cursor: _Cursor(),
      ),
    );
  }

  PinTheme _defaultPinTheme(BuildContext context) {
    return PinTheme(
      width: 56,
      height: 56,
      textStyle: AppFontStyle.medium18(
        context,
      ).copyWith(color: AppColors.black),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: hasError ? AppColors.red : AppColors.gray30,
          width: 1,
        ),
      ),
    );
  }

  PinTheme _focusedPinTheme(BuildContext context) {
    return _defaultPinTheme(context).copyWith(
      decoration: _defaultPinTheme(context).decoration?.copyWith(
        border: Border.all(
          color: hasError ? AppColors.red : AppColors.primaryBlue,
          width: 2,
        ),
      ),
    );
  }

  PinTheme _submittedPinTheme(BuildContext context) {
    return _defaultPinTheme(context).copyWith(
      decoration: _defaultPinTheme(context).decoration?.copyWith(
        border: Border.all(
          color: hasError ? AppColors.red : AppColors.primaryBlue,
          width: 1,
        ),
      ),
    );
  }

  PinTheme _errorPinTheme(BuildContext context) {
    return _defaultPinTheme(context).copyWith(
      decoration: _defaultPinTheme(context).decoration?.copyWith(
        border: Border.all(color: AppColors.red, width: 1),
      ),
    );
  }
}

class _Cursor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 24,
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}
