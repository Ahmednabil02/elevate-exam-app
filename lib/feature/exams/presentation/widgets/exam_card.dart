import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/values/app_assets.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ExamCard extends StatelessWidget {
  const ExamCard({super.key, required this.exam});

  final ExamEntity exam;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => context.push(Routes.examDetails, extra: {"exam": exam}),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          shape: BoxShape.rectangle,
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.25),
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset.zero,
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Row(
          children: [
            SizedBox(
              width: 60.w,
              height: 72.h,
              child: Image.asset(AppAssets.profit, fit: BoxFit.cover),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          exam.title,
                          style: AppFontStyle.medium16(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (exam.duration != null)
                        Text(
                          "${exam.duration} ${AppStrings.minutes}",
                          style: AppFontStyle.regular13(
                            context,
                          ).copyWith(color: theme.colorScheme.primary),
                        ),
                    ],
                  ),
                  if (exam.numberOfQuestions != null)
                    Text(
                      "${exam.numberOfQuestions} ${AppStrings.questions}",
                      style: AppFontStyle.regular13(
                        context,
                      ).copyWith(color: theme.textTheme.bodySmall?.color),
                    ),
                  SizedBox(height: 16.h),
                  Wrap(
                    spacing: 10.w,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: AppStrings.fromHour,
                          style: AppFontStyle.regular13(context),
                          children: [
                            TextSpan(
                              text: exam.startTime,
                              style: AppFontStyle.medium13(context),
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          text: AppStrings.toHour,
                          style: AppFontStyle.regular13(context),
                          children: [
                            TextSpan(
                              text: exam.endTime,
                              style: AppFontStyle.medium13(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
