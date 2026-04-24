import 'dart:math';
import 'package:flutter/material.dart';

class ScoreCirclePainter extends CustomPainter {
  const ScoreCirclePainter({
    required this.percentage,
    required this.correctColor,
    required this.incorrectColor,
    required this.backgroundColor,
    this.strokeWidth = 12.0,
  });

  final int percentage;
  final Color correctColor;
  final Color incorrectColor;
  final Color backgroundColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Calculate angles
    final correctSweepAngle = (percentage / 100) * 2 * pi;
    final incorrectSweepAngle = ((100 - percentage) / 100) * 2 * pi;

    // Start angle (top of circle = -90 degrees = -pi/2)
    const startAngle = -pi / 2;

    // Draw correct arc (blue)
    if (percentage > 0) {
      final correctPaint = Paint()
        ..color = correctColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        correctSweepAngle,
        false,
        correctPaint,
      );
    }

    // Draw incorrect arc (red)
    if (percentage < 100) {
      final incorrectPaint = Paint()
        ..color = incorrectColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle + correctSweepAngle,
        incorrectSweepAngle,
        false,
        incorrectPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant ScoreCirclePainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.correctColor != correctColor ||
        oldDelegate.incorrectColor != incorrectColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
