import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AnswerState {
  correctAndSelected,
  correctAndNotSelected,
  incorrectAndSelected,
  incorrectAndNotSelected,
}

class AnswerOptionItem extends StatelessWidget {
  const AnswerOptionItem({super.key, required this.text, required this.state});

  final String text;
  final AnswerState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
      decoration: _getDecoration(),
      child: Row(
        children: [
          _AnswerIndicator(state: state),
          SizedBox(width: 18.w),
          Expanded(child: Text(text, style: AppFontStyle.regular14(context))),
        ],
      ),
    );
  }

  BoxDecoration _getDecoration() {
    switch (state) {
      case AnswerState.correctAndSelected:
      case AnswerState.correctAndNotSelected:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.greenCc,
          border: Border.all(color: AppColors.green19, width: 1),
        );
      case AnswerState.incorrectAndSelected:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.redD2,
          border: Border.all(color: AppColors.red, width: 1),
        );
      case AnswerState.incorrectAndNotSelected:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.grayF3,
        );
    }
  }
}

class _AnswerIndicator extends StatelessWidget {
  const _AnswerIndicator({required this.state});

  final AnswerState state;

  @override
  Widget build(BuildContext context) {
    final isSelected =
        state == AnswerState.correctAndSelected ||
        state == AnswerState.correctAndNotSelected ||
        state == AnswerState.incorrectAndSelected;
    final borderColor = _getBorderColor();

    return Container(
      width: 20.w,
      height: 20.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2, color: borderColor),
      ),
      child: isSelected
          ? Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color: borderColor,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }

  Color _getBorderColor() {
    switch (state) {
      case AnswerState.correctAndSelected:
      case AnswerState.correctAndNotSelected:
        return AppColors.green19;
      case AnswerState.incorrectAndSelected:
        return AppColors.red;
      case AnswerState.incorrectAndNotSelected:
        return AppColors.primaryBlue;
    }
  }
}
