import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamInstructions extends StatelessWidget {
  const ExamInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.instructions, style: AppFontStyle.medium18(context)),
        SizedBox(height: 12.h),
        InstructionItem(text: AppStrings.instruction),
        InstructionItem(text: AppStrings.instruction),
        InstructionItem(text: AppStrings.instruction),
        InstructionItem(text: AppStrings.instruction),
      ],
    );
  }
}

class InstructionItem extends StatelessWidget {
  final String text;

  const InstructionItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6.w,
            height: 6.h,
            margin: EdgeInsetsDirectional.only(top: 8.h, end: 8.w),
            decoration: const BoxDecoration(
              color: AppColors.black,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppFontStyle.regular14(
                context,
              ).copyWith(color: AppColors.gray53),
            ),
          ),
        ],
      ),
    );
  }
}
