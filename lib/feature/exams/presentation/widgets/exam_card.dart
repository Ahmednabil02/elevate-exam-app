import 'package:exam_app/core/values/app_assets.dart';
import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exams/presentation/widgets/row_span.dart';
import 'package:exam_app/feature/exams/presentation/widgets/start_exam_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamCard extends StatelessWidget {
  const ExamCard({super.key, required this.exam});
  final ExamEntity exam;

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => StartExamBottomSheet(exam: exam),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBottomSheet(context),
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
            _ExamThumbnail(),
            SizedBox(width: 8.w),
            Expanded(child: _ExamDetails(exam: exam)),
          ],
        ),
      ),
    );
  }
}

class _ExamThumbnail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      height: 72.h,
      child: Image.asset(AppAssets.profit, fit: BoxFit.cover),
    );
  }
}

class _ExamDetails extends StatelessWidget {
  const _ExamDetails({required this.exam});
  final ExamEntity exam;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            Text(
              "${exam.duration} ${AppStrings.minutes}",
              style: AppFontStyle.regular13(
                context,
              ).copyWith(color: AppColors.primaryBlue),
            ),
          ],
        ),
        Text(
          "${exam.numberOfQuestions} ${AppStrings.questions}",
          style: AppFontStyle.regular13(
            context,
          ).copyWith(color: AppColors.gray53),
        ),
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
