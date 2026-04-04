import 'package:exam_app/core/values/app_assets.dart';
import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyExamsWidget extends StatelessWidget {
  const EmptyExamsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EmptyExamsImage(),
        SizedBox(height: 20.h),
        EmptyExamsText(),
      ],
    );
  }
}

class EmptyExamsImage extends StatelessWidget {
  const EmptyExamsImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      width: 100.w,
      child: Image.asset(AppAssets.profit, fit: BoxFit.contain),
    );
  }
}

class EmptyExamsText extends StatelessWidget {
  const EmptyExamsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.noDataFound,
      style: AppFontStyle.regular20(context).copyWith(color: AppColors.gray30),
      textAlign: TextAlign.center,
      maxLines: 2,
    );
  }
}
