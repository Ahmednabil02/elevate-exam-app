import 'package:flutter/material.dart';
import 'package:exam_app/core/values/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamsSliverShimmer extends StatelessWidget {
  final int itemCount;

  const ExamsSliverShimmer({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => const ExamCardShimmer(),
        childCount: itemCount,
      ),
    );
  }
}

class ExamCardShimmer extends StatelessWidget {
  const ExamCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShimmerDecoration(),
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(width: 60.w, height: 71.h),
          SizedBox(width: 8.w),
          Expanded(child: ExamDetailsShimmer()),
        ],
      ),
    );
  }
}

class ShimmerDecoration extends BoxDecoration {
  ShimmerDecoration()
    : super(
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
      );
}

class ExamDetailsShimmer extends StatelessWidget {
  const ExamDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        ShimmerTitleRow(),
        ShimmerBox(width: 48.w, height: 12.h, borderRadius: 16.r),
        ShimmerTimeRow(),
      ],
    );
  }
}

class ShimmerTitleRow extends StatelessWidget {
  const ShimmerTitleRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 16.h,
      children: [
        Flexible(
          child: ShimmerBox(width: 108.w, height: 16.h, borderRadius: 16.r),
        ),
        ShimmerBox(width: 54.w, height: 12.h, borderRadius: 16.r),
      ],
    );
  }
}

class ShimmerTimeRow extends StatelessWidget {
  const ShimmerTimeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      children: [
        ShimmerBox(width: 36.w, height: 12.h, borderRadius: 16.r),
        ShimmerBox(width: 36.w, height: 12.h, borderRadius: 16.r),
      ],
    );
  }
}

class ShimmerBox extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  State<ShimmerBox> createState() => ShimmerBoxState();
}

class ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = _createAnimation();
  }

  Animation<double> _createAnimation() {
    return Tween<double>(
      begin: -1,
      end: 2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => ShimmerContainer(
        width: widget.width,
        height: widget.height,
        borderRadius: widget.borderRadius,
        animationValue: _animation.value,
      ),
    );
  }
}

class ShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final double animationValue;

  const ShimmerContainer({
    super.key,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.animationValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [AppColors.gray10, AppColors.lightGray, AppColors.gray10],
          stops: [
            animationValue - 0.3,
            animationValue,
            animationValue + 0.3,
          ].map((e) => e.clamp(0.0, 1.0)).toList(),
        ),
      ),
    );
  }
}
