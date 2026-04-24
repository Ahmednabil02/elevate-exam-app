import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionNavigationButtons extends StatelessWidget {
  const QuestionNavigationButtons({
    super.key,
    required this.currentPage,
    required this.nextButtonText,
    required this.onBack,
    required this.onNext,
  });

  final int currentPage;
  final String nextButtonText;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (currentPage > 0) ...[
          Expanded(
            child: CustomButton(
              text: AppStrings.back,
              height: 48.h,
              variant: ButtonVariant.outlined,
              onPressed: onBack,
              radius: 10,
            ),
          ),
          SizedBox(width: 12.w),
        ],
        Expanded(
          child: CustomButton(
            text: nextButtonText,
            height: 48.h,
            onPressed: onNext,
            radius: 10,
          ),
        ),
      ],
    );
  }
}
