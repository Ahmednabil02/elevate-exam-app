import 'package:exam_app/core/widgets/base_state_builder.dart';
import 'package:exam_app/core/widgets/loading_indicator.dart';
import 'package:exam_app/feature/answers/presentation/cubit/answers_cubit.dart';
import 'package:exam_app/feature/answers/presentation/widgets/answer_card.dart';
import 'package:exam_app/feature/questions/domain/entities/questions_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnswersBody extends StatelessWidget {
  const AnswersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnswersCubit, AnswersState>(
      builder: (context, state) {
        return BaseStateBuilder<List<QuestionEntity>>(
          state: state,
          onLoading: (context) => const CenteredLoadingIndicator(),
          onSuccess: (context, questions) {
            return SafeArea(child: _AnswersList(questions: questions));
          },
          onError: (context, exception) {
            return Center(
              child: Text(exception.toString(), textAlign: TextAlign.center),
            );
          },
        );
      },
    );
  }
}

class _AnswersList extends StatelessWidget {
  const _AnswersList({required this.questions});

  final List<QuestionEntity> questions;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: questions.length,
      separatorBuilder: (context, index) => SizedBox(height: 24.h),
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return AnswerCard(
          question: questions[index],
          questionNumber: index + 1,
        );
      },
    );
  }
}
