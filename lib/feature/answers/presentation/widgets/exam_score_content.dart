import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/feature/answers/domain/entities/exam_result_entity.dart';
import 'package:exam_app/feature/answers/presentation/widgets/score_circle_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamScoreContent extends StatelessWidget {
  const ExamScoreContent({
    super.key,
    required this.result,
    required this.onShowResults,
    required this.onStartAgain,
  });

  final ExamResultEntity result;
  final VoidCallback onShowResults;
  final VoidCallback onStartAgain;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            _YourScoreTitle(),
            SizedBox(height: 40.h),
            _ScoreSection(result: result),
            const Spacer(),
            _ActionButtons(
              onShowResults: onShowResults,
              onStartAgain: onStartAgain,
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}

class _YourScoreTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(AppStrings.yourScore, style: AppFontStyle.regular20(context));
  }
}

class _ScoreSection extends StatelessWidget {
  const _ScoreSection({required this.result});

  final ExamResultEntity result;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _CircularScore(scorePercentage: result.scorePercentage),
        SizedBox(width: 40.w),
        Expanded(child: _ScoreStats(result: result)),
      ],
    );
  }
}

class _CircularScore extends StatelessWidget {
  const _CircularScore({required this.scorePercentage});

  final int scorePercentage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.w,
      height: 160.w,
      child: CustomPaint(
        painter: ScoreCirclePainter(
          percentage: scorePercentage,
          correctColor: AppColors.primaryBlue,
          incorrectColor: AppColors.red,
          backgroundColor: AppColors.lightGray,
        ),
        child: Center(
          child: Text(
            '$scorePercentage%',
            style: AppFontStyle.bold24(context).copyWith(fontSize: 32.sp),
          ),
        ),
      ),
    );
  }
}

class _ScoreStats extends StatelessWidget {
  const _ScoreStats({required this.result});

  final ExamResultEntity result;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StatRow(
          label: AppStrings.correct,
          value: result.correctAnswers,
          color: AppColors.primaryBlue,
        ),
        SizedBox(height: 16.h),
        _StatRow(
          label: AppStrings.incorrect,
          value: result.incorrectAnswers,
          color: AppColors.red,
        ),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20.w,
          height: 20.w,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        SizedBox(width: 12.w),
        Text(label, style: AppFontStyle.regular16(context)),
        const Spacer(),
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Text(
              '$value',
              style: AppFontStyle.medium14(context).copyWith(color: color),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.onShowResults,
    required this.onStartAgain,
  });

  final VoidCallback onShowResults;
  final VoidCallback onStartAgain;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(text: AppStrings.showResults, onPressed: onShowResults),
        SizedBox(height: 16.h),
        CustomButton(
          text: AppStrings.startAgain,
          onPressed: onStartAgain,
          variant: ButtonVariant.outlined,
          backgroundColor: AppColors.primaryBlue,
          textColor: AppColors.primaryBlue,
        ),
      ],
    );
  }
}
