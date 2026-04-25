import 'package:exam_app/core/values/app_assets.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/subject/domain/models/subject_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamHeader extends StatelessWidget {
  final ExamEntity exam;
  final SubjectEntity subject;

  const ExamHeader({super.key, required this.exam, required this.subject});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      spacing: 8.h,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8.w,
          children: [
            SizedBox(
              width: 42.w,
              height: 47.h,
              child: Image.asset(AppAssets.profit, fit: BoxFit.cover),
            ),
            Expanded(
              child: Text(
                subject.name ?? '',
                style: AppFontStyle.medium16(context),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          spacing: 4.w,
          children: [
            Flexible(
              child: Container(
                padding: EdgeInsetsDirectional.only(end: 6.w),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: theme.dividerColor, width: 1),
                  ),
                ),
                child: Text(
                  exam.title,
                  style: AppFontStyle.medium18(context),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
            if (exam.numberOfQuestions != null)
              Text(
                "${exam.numberOfQuestions} ${AppStrings.questions}",
                style: AppFontStyle.regular13(context).copyWith(fontSize: 16),
              ),
          ],
        ),
      ],
    );
  }
}
