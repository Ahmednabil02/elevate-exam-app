import 'dart:async';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:flutter/material.dart';

class ExamTimerWidget extends StatefulWidget {
  final DateTime startTime;
  final int durationInMinutes;
  final VoidCallback? onTimeExpired;

  const ExamTimerWidget({
    super.key,
    required this.startTime,
    required this.durationInMinutes,
    this.onTimeExpired,
  });

  @override
  State<ExamTimerWidget> createState() => _ExamTimerWidgetState();
}

class _ExamTimerWidgetState extends State<ExamTimerWidget> {
  Timer? _timer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calculateRemainingTime();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _calculateRemainingTime() {
    final now = DateTime.now();
    final endTime = widget.startTime.add(
      Duration(minutes: widget.durationInMinutes),
    );
    final remaining = endTime.difference(now);

    setState(() {
      _remainingTime = remaining.isNegative ? Duration.zero : remaining;
    });

    if (_remainingTime == Duration.zero) {
      widget.onTimeExpired?.call();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateRemainingTime();
    });
  }

  Color _getTimerColor() {
    final totalMinutes = widget.durationInMinutes;
    final remainingMinutes = _remainingTime.inMinutes;

    if (remainingMinutes <= totalMinutes * 0.1) {
      return Colors.red;
    } else if (remainingMinutes <= totalMinutes * 0.25) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:'
          '${seconds.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.timer_outlined, color: _getTimerColor(), size: 20),
        const SizedBox(width: 8),
        Text(
          _formatDuration(_remainingTime),
          style: AppFontStyle.regular20(
            context,
          ).copyWith(color: _getTimerColor()),
        ),
      ],
    );
  }
}
