import 'package:exam_app/core/widgets/base_state_builder.dart';
import 'package:exam_app/core/widgets/loading_indicator.dart';
import 'package:exam_app/feature/answers/presentation/cubit/answers_cubit.dart';
import 'package:exam_app/feature/answers/presentation/widgets/exam_score_content.dart';
import 'package:exam_app/feature/questions/domain/entities/questions_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamScoreBody extends StatelessWidget {
  const ExamScoreBody({
    super.key,
    required this.onShowResults,
    required this.onStartAgain,
  });

  final VoidCallback onShowResults;
  final VoidCallback onStartAgain;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnswersCubit, AnswersState>(
      builder: (context, state) {
        return BaseStateBuilder<List<QuestionEntity>>(
          state: state,
          onLoading: (context) => const CenteredLoadingIndicator(),
          onSuccess: (context, questions) {
            if (state.result == null) {
              return const Center(child: Text('No result available'));
            }

            return ExamScoreContent(
              result: state.result!,
              onShowResults: onShowResults,
              onStartAgain: onStartAgain,
            );
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
