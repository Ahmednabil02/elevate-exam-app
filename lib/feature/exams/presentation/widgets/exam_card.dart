import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/values/app_assets.dart';
import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exams/presentation/widgets/row_span.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ExamCard extends StatelessWidget {
  const ExamCard({super.key, required this.exam});

  final ExamEntity exam;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(Routes.examDetails, extra: {"exam": exam}),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          shape: BoxShape.rectangle,
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor.withValues(alpha: 0.25),
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
            ExamIcon(),
            SizedBox(width: 8.w),
            Expanded(child: ExamDetails(exam: exam)),
          ],
        ),
      ),
    );
  }
}

class ExamIcon extends StatelessWidget {
  final double width, height;

  const ExamIcon({super.key, this.width = 60, this.height = 72});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: Image.asset(AppAssets.profit, fit: BoxFit.cover),
    );
  }
}

class ExamDetails extends StatelessWidget {
  const ExamDetails({super.key, required this.exam});

  final ExamEntity exam;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExamTitle(exam: exam),
        ExamQuestions(numberOfQuestions: exam.numberOfQuestions),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 10.w,
          children: [
            RowSpan(title: AppStrings.fromHour, spanTitle: exam.startTime),
            RowSpan(title: AppStrings.toHour, spanTitle: exam.endTime),
          ],
        ),
      ],
    );
  }
}

class ExamTitle extends StatelessWidget {
  final ExamEntity exam;
  final TextStyle? titleStyle;
  const ExamTitle({super.key, required this.exam, this.titleStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            exam.title,
            style: titleStyle ?? AppFontStyle.medium16(context),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        ExamDuration(duration: exam.duration),
      ],
    );
  }
}

class ExamDuration extends StatelessWidget {
  final int? duration;

  const ExamDuration({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    return duration == null
        ? SizedBox.shrink()
        : Text(
            "$duration ${AppStrings.minutes}",
            style: AppFontStyle.regular13(
              context,
            ).copyWith(color: AppColors.primaryBlue),
          );
  }
}

class ExamQuestions extends StatelessWidget {
  final int? numberOfQuestions;
  final double fontSize;

  const ExamQuestions({
    super.key,
    required this.numberOfQuestions,
    this.fontSize = 13,
  });

  @override
  Widget build(BuildContext context) {
    return numberOfQuestions == null
        ? SizedBox.shrink()
        : Text(
            "$numberOfQuestions ${AppStrings.questions}",
            style: AppFontStyle.regular13(
              context,
            ).copyWith(color: AppColors.gray53, fontSize: fontSize),
          );
  }
}
