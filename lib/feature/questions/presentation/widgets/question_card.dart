import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/feature/questions/domain/entities/questions_entity.dart';
import 'package:exam_app/feature/questions/presentation/widgets/question_option_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.question,
    required this.onAnswerSelected,
  });

  final QuestionEntity question;
  final Function(String answer) onAnswerSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question.questionTitle, style: AppFontStyle.medium18(context)),
        SizedBox(height: 16.h),
        ...question.answers.map(
          (answer) => QuestionOptionItem(
            text: answer.title,
            isSelected: question.answeredQuestion == answer.title,
            onTap: () => onAnswerSelected(answer.title),
          ),
        ),
      ],
    );
  }
}
