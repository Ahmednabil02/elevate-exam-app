import 'package:flutter/material.dart';
import 'package:exam_app/core/values/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamsShimmer extends StatelessWidget {
  final int itemCount;

  const ExamsShimmer({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) => const ExamCardShimmer(),
    );
  }
}

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ShimmerBox(width: 60.w, height: 71.h),
          SizedBox(width: 8.w),
          Expanded(child: _ExamDetails()),
        ],
      ),
    );
  }
}

class _ExamDetails extends StatelessWidget {
  const _ExamDetails();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 16.h,
          children: [
            Flexible(
              child: _ShimmerBox(
                width: 108.w,
                height: 16.h,
                borderRadius: 16.r,
              ),
            ),
            _ShimmerBox(width: 54.w, height: 12.h, borderRadius: 16.r),
          ],
        ),
        _ShimmerBox(width: 48.w, height: 12.h, borderRadius: 16.r),

        Wrap(
          spacing: 10.w,
          children: [
            _ShimmerBox(width: 36.w, height: 12.h, borderRadius: 16.r),
            _ShimmerBox(width: 36.w, height: 12.h, borderRadius: 16.r),
          ],
        ),
      ],
    );
  }
}

class _ShimmerBox extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const _ShimmerBox({
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
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

    _animation = Tween<double>(
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
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.grey[300]!, Colors.grey[200]!, Colors.grey[300]!],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((e) => e.clamp(0.0, 1.0)).toList(),
            ),
          ),
        );
      },
    );
  }
}
