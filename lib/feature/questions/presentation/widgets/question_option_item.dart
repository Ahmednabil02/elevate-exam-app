import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionOptionItem extends StatelessWidget {
  const QuestionOptionItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: isSelected ? AppColors.blue10 : AppColors.grayF3,
        ),
        child: Row(
          children: [
            _RadioButton(isSelected: isSelected),
            SizedBox(width: 18.w),
            Expanded(child: Text(text, style: AppFontStyle.regular14(context))),
          ],
        ),
      ),
    );
  }
}

class _RadioButton extends StatelessWidget {
  const _RadioButton({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 20.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2, color: AppColors.primaryBlue),
      ),
      child: isSelected
          ? Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 10.w,
                height: 10.w,
                decoration: const BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }
}
