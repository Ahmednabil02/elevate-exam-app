import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exams/presentation/widgets/exam_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamHeader extends StatelessWidget {
  final ExamEntity exam;

  const ExamHeader({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8.w,
          children: [
            ExamIcon(width: 42, height: 47),
            Expanded(child: ExamTitle(exam: exam)),
          ],
        ),
        ExamInfo(exam: exam),
      ],
    );
  }
}

class ExamInfo extends StatelessWidget {
  final ExamEntity exam;

  const ExamInfo({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 4.w,
      children: [
        Container(
          padding: EdgeInsetsDirectional.only(end: 4.w),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: AppColors.blueCD, width: 1),
            ),
          ),
          child: Text(
            exam.subject,
            style: AppFontStyle.medium18(
              context,
            ).copyWith(color: AppColors.blackBase),
          ),
        ),
        ExamQuestions(numberOfQuestions: exam.numberOfQuestions, fontSize: 16),
      ],
    );
  }
}
