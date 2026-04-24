import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyQuestionsWidget extends StatelessWidget {
  const EmptyQuestionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.quiz_outlined,
            size: 80.sp,
            color: theme.colorScheme.primary.withValues(alpha: 0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            AppStrings.noQuestion,
            style: AppFontStyle.medium16(
              context,
            ).copyWith(color: theme.textTheme.bodySmall?.color),
          ),
        ],
      ),
    );
  }
}
