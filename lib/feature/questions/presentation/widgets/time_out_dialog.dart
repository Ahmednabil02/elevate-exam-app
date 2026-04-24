import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/values/app_assets.dart';
import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TimeOutDialog extends StatelessWidget {
  const TimeOutDialog({super.key, required this.examEntity});

  final ExamEntity examEntity;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 4,
                children: [
                  Image.asset(AppAssets.sandClock1, width: 48.w, height: 96.h),

                  Text(
                    AppStrings.timeOut,
                    style: AppFontStyle.regular24(
                      context,
                    ).copyWith(color: AppColors.red10),
                  ),
                ],
              ),
              SizedBox(height: 28.h),
              CustomButton(
                text: AppStrings.viewScore,
                onPressed: () {
                  context.pop();
                  context.push(Routes.questions, extra: {"exam": examEntity});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
