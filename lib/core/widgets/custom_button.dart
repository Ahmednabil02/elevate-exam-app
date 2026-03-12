import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../values/app_colors.dart';
import '../values/app_font_style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = isEnabled && !isLoading && onPressed != null;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled
              ? (backgroundColor ?? AppColors.primaryBlue)
              : AppColors.gray30,
          foregroundColor: textColor ?? AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const _LoadingIndicator()
            : Text(
                text,
                style: AppFontStyle.medium18(
                  context,
                ).copyWith(color: textColor ?? AppColors.white),
              ),
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CupertinoActivityIndicator(color: AppColors.white),
    );
  }
}
