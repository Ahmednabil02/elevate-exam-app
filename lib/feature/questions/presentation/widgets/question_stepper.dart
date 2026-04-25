import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionStepper extends StatelessWidget {
  const QuestionStepper({
    super.key,
    required this.totalQuestions,
    required this.currentQuestion,
  });

  final int totalQuestions;
  final int currentQuestion;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.questionOf(
                current: currentQuestion,
                total: totalQuestions,
              ),
              style: AppFontStyle.medium14(
                context,
              ).copyWith(color: AppColors.gray53),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        SizedBox(
          width: 1.sw,
          height: 3.h,
          child: Stack(
            children: [
              Container(
                width: 1.sw,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.gray10,
                  borderRadius: BorderRadius.circular(1000.r),
                ),
              ),
              Container(
                width: (currentQuestion / totalQuestions) * 1.sw,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(1000.r),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
