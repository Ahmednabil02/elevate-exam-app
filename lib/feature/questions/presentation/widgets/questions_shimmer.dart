import 'package:exam_app/core/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class QuestionsShimmer extends StatelessWidget {
  const QuestionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            const _StepperShimmer(),
            SizedBox(height: 24.h),
            const Expanded(
              child: SingleChildScrollView(child: _QuestionCardShimmer()),
            ),
            SizedBox(height: 16.h),
            const _NavigationButtonsShimmer(),
          ],
        ),
      ),
    );
  }
}

class _StepperShimmer extends StatelessWidget {
  const _StepperShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray10,
      highlightColor: AppColors.lightGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 16.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionCardShimmer extends StatelessWidget {
  const _QuestionCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: AppColors.gray10,
        highlightColor: AppColors.lightGray,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuestionTitle(),
            SizedBox(height: 16.h),
            ...List.generate(4, (index) => _buildOptionShimmer()),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 18.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: 200.w,
          height: 18.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionShimmer() {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.whiteF9,
      ),
      child: Row(
        children: [
          _buildRadioShimmer(),
          SizedBox(width: 18.w),
          Expanded(child: _buildTextShimmer()),
        ],
      ),
    );
  }

  Widget _buildRadioShimmer() {
    return Container(
      width: 20.w,
      height: 20.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.gray10, width: 2),
      ),
    );
  }

  Widget _buildTextShimmer() {
    return Container(
      height: 14.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}

class _NavigationButtonsShimmer extends StatelessWidget {
  const _NavigationButtonsShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray10,
      highlightColor: AppColors.lightGray,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(100.r),
                border: Border.all(color: AppColors.gray10, width: 2),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
