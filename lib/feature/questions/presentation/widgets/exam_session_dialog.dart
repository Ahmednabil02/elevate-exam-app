import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ExamSessionDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? subtitle;
  final String confirmText;
  final String? cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final Color? titleColor;

  const ExamSessionDialog({
    super.key,
    required this.title,
    required this.message,
    this.subtitle,
    required this.confirmText,
    this.cancelText,
    required this.onConfirm,
    this.onCancel,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: theme.colorScheme.surface,
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              Text(
                title,
                style: AppFontStyle.bold24(
                  context,
                ).copyWith(color: titleColor ?? AppColors.primaryBlue),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                message,
                style: AppFontStyle.regular16(context),
                textAlign: TextAlign.center,
              ),
              if (subtitle != null) ...[
                SizedBox(height: 12.h),
                Text(
                  subtitle!,
                  style: AppFontStyle.regular14(
                    context,
                  ).copyWith(color: AppColors.warning),
                  textAlign: TextAlign.center,
                ),
              ],
              SizedBox(height: 28.h),
              Row(
                spacing: 12,
                children: [
                  if (cancelText != null && onCancel != null) ...[
                    Expanded(
                      child: CustomButton(
                        text: cancelText!,
                        variant: ButtonVariant.outlined,
                        radius: 10,
                        onPressed: () {
                          context.pop();
                          onCancel!();
                        },

                        textColor: AppColors.primaryBlue,
                      ),
                    ),
                  ],
                  Expanded(
                    child: CustomButton(
                      text: confirmText,
                      radius: 10,

                      onPressed: () {
                        context.pop();
                        onConfirm();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  factory ExamSessionDialog.expired({
    required VoidCallback onRestart,
    required VoidCallback onCancel,
  }) {
    return ExamSessionDialog(
      title: AppStrings.examExpiredTitle,
      message: AppStrings.examExpiredMessage,
      subtitle: AppStrings.examExpiredSubtitle,
      confirmText: AppStrings.retakeExam,
      cancelText: AppStrings.cancel,
      titleColor: AppColors.warning,
      onConfirm: onRestart,
      onCancel: onCancel,
    );
  }

  factory ExamSessionDialog.resume({
    required VoidCallback onResume,
    required VoidCallback onRestart,
  }) {
    return ExamSessionDialog(
      title: AppStrings.resumeExamTitle,
      message: AppStrings.resumeExamMessage,
      confirmText: AppStrings.resumeExam,
      cancelText: AppStrings.startNewExam,
      onConfirm: onResume,
      onCancel: onRestart,
    );
  }

  factory ExamSessionDialog.completed({
    required VoidCallback onViewResults,
    required VoidCallback onRestart,
  }) {
    return ExamSessionDialog(
      title: AppStrings.examCompletedTitle,
      message: AppStrings.examCompletedMessage,
      confirmText: AppStrings.viewResults,
      cancelText: AppStrings.startNewExam,
      titleColor: AppColors.green19,
      onConfirm: onViewResults,
      onCancel: onRestart,
    );
  }
}
