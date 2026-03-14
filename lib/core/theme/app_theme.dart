import 'package:flutter/material.dart';

import '../values/app_colors.dart';
import '../values/app_font_style.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.primaryBlue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlue,
        primary: AppColors.primaryBlue,
        error: AppColors.red,
        surface: AppColors.whiteF9,
      ),
      scaffoldBackgroundColor: AppColors.whiteF9,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppColors.black,
          fontSize: 20,
          fontWeight: FontWeightHelper.medium,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.gray30,
          disabledForegroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          minimumSize: const Size(double.infinity, 48),
          elevation: 0,
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeightHelper.medium,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.gray30, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.gray30, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.primaryBlue, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.red, width: 1),
        ),
        labelStyle: TextStyle(
          color: AppColors.darkGray,
          fontSize: 12,
          fontWeight: FontWeightHelper.regular,
        ),
        hintStyle: TextStyle(
          color: AppColors.grayA6,
          fontSize: 14,
          fontWeight: FontWeightHelper.regular,
        ),
        errorStyle: TextStyle(
          color: AppColors.red,
          fontSize: 12,
          fontWeight: FontWeightHelper.regular,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        side: const BorderSide(color: AppColors.gray30, width: 2),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryBlue,
          textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeightHelper.regular,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return lightTheme;
  }
}
