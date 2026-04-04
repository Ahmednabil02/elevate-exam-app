import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:flutter/material.dart';

class RowSpan extends StatelessWidget {
  const RowSpan({super.key, required this.title, required this.spanTitle});
  final String title;
  final String spanTitle;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: title,
        style: AppFontStyle.regular13(
          context,
        ).copyWith(color: AppColors.blackBase),
        children: [
          TextSpan(
            text: spanTitle,
            style: AppFontStyle.medium13(
              context,
            ).copyWith(color: AppColors.blackBase),
          ),
        ],
      ),
    );
  }
}
