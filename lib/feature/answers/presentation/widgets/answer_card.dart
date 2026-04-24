import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/feature/answers/presentation/widgets/answer_widget.dart';
import 'package:exam_app/feature/questions/domain/entities/answer_entity.dart';
import 'package:exam_app/feature/questions/domain/entities/questions_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    super.key,
    required this.question,
    required this.questionNumber,
  });

  final QuestionEntity question;
  final int questionNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _QuestionHeader(
            questionNumber: questionNumber,
            questionTitle: question.questionTitle,
          ),
          SizedBox(height: 16.h),
          _AnswersList(question: question),
        ],
      ),
    );
  }
}

class _QuestionHeader extends StatelessWidget {
  const _QuestionHeader({
    required this.questionNumber,
    required this.questionTitle,
  });

  final int questionNumber;
  final String questionTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$questionNumber. ', style: AppFontStyle.medium18(context)),
        Expanded(
          child: Text(questionTitle, style: AppFontStyle.medium18(context)),
        ),
      ],
    );
  }
}

class _AnswersList extends StatelessWidget {
  const _AnswersList({required this.question});

  final QuestionEntity question;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: question.answers.length,
      itemBuilder: (context, index) {
        final answer = question.answers[index];
        final state = _getAnswerState(answer.title);

        return AnswerOptionItem(text: answer.title, state: state);
      },
    );
  }

  AnswerState _getAnswerState(String answerTitle) {
    final correctAnswer = question.answers
        .firstWhere(
          (answer) => answer.key == question.correctAnswer,
          orElse: () => AnswerEntity(key: '', title: ''),
        )
        .title;
    final isCorrect = answerTitle == correctAnswer;
    final isSelected = answerTitle == question.answeredQuestion;

    if (isCorrect && isSelected) {
      return AnswerState.correctAndSelected;
    } else if (isCorrect && !isSelected) {
      return AnswerState.correctAndNotSelected;
    } else if (!isCorrect && isSelected) {
      return AnswerState.incorrectAndSelected;
    } else {
      return AnswerState.incorrectAndNotSelected;
    }
  }
}
