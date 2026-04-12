import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exams/presentation/widgets/exam_details_body.dart';
import 'package:flutter/material.dart';

class ExamDetailsPage extends StatelessWidget {
  final ExamEntity exam;
  const ExamDetailsPage({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteF9,
      appBar: const CustomAppBar(title: ''),
      body: ExamDetailsBody(exam: exam),
    );
  }
}
