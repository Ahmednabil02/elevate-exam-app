import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/core/widgets/base_state_builder.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/questions/domain/entities/questions_entity.dart';
import 'package:exam_app/feature/questions/presentation/cubit/questions_cubit.dart';
import 'package:exam_app/feature/questions/presentation/widgets/empty_questions_widget.dart';
import 'package:exam_app/feature/questions/presentation/widgets/questions_content.dart';
import 'package:exam_app/feature/questions/presentation/widgets/questions_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionsBody extends StatelessWidget {
  final ExamEntity examEntity;

  const QuestionsBody({super.key, required this.examEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      builder: (context, state) {
        return BaseStateBuilder<List<QuestionEntity>>(
          state: state,
          onLoading: (context) => const QuestionsShimmer(),
          onError: (context, exception) => Center(
            child: Text(
              '${AppStrings.errorLoadingQuestions} ${exception.toString()}',
            ),
          ),
          onSuccess: (context, questions) => questions.isEmpty
              ? const EmptyQuestionsWidget()
              : QuestionsContent(
                  questions: questions,
                  currentPage: state.currentPage,
                ),
        );
      },
    );
  }
}
