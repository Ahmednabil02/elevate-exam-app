import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final String subtitle;

  const Header({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppFontStyle.semiBold18(
            context,
          ).copyWith(color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        Text(
          subtitle,
          style: AppFontStyle.regular14(
            context,
          ).copyWith(color: AppColors.darkGray),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
