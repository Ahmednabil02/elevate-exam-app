import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exams/presentation/widgets/exam_header.dart';
import 'package:exam_app/feature/exams/presentation/widgets/exam_instructions.dart';
import 'package:exam_app/feature/subject/domain/models/subject_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ExamDetailsBody extends StatelessWidget {
  final ExamEntity exam;
  final SubjectEntity subject;
  const ExamDetailsBody({super.key, required this.exam, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExamHeader(exam: exam, subject: subject),
          SizedBox(height: 24.h),
          const ExamInstructions(),
          const Spacer(),
          CustomButton(
            text: AppStrings.startExam,
            onPressed: () {
              context.push(Routes.questions, extra: {"exam": exam});
            },
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
