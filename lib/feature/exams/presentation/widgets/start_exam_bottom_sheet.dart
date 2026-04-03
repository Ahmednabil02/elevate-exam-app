import 'package:exam_app/core/values/app_assets.dart';
import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:flutter/material.dart';

class StartExamBottomSheet extends StatelessWidget {
  const StartExamBottomSheet({super.key, required this.exam,});
  final ExamEntity exam;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              spacing: 8,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Image.asset(AppAssets.profit, fit: BoxFit.contain),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(exam.title, style: AppFontStyle.semiBold20(context)),
                    Text(
                      "${exam.numberOfQuestions} Questions",
                      style: AppFontStyle.regular16(
                        context,
                      ).copyWith(color: AppColors.gray53),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  '${exam.duration} min',
                  style: AppFontStyle.regular13(
                    context,
                  ).copyWith(color: AppColors.blue40),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: "Start Exam",
              onPressed: () {
                Navigator.pop(context);
                // TODO: navigate to questions with exam & subject
              },
            ),
          ],
        ),
      ),
    );
  }
}
