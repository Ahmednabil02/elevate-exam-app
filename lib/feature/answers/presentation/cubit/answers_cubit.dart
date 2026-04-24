import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/config/base_state/state_types.dart';
import 'package:exam_app/feature/answers/domain/entities/exam_result_entity.dart';
import 'package:exam_app/feature/answers/presentation/cubit/answers_events.dart';
import 'package:exam_app/feature/questions/domain/entities/answer_entity.dart';
import 'package:exam_app/feature/questions/domain/entities/questions_entity.dart';
import 'package:exam_app/feature/questions/domain/use_cases/get_saved_questions_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'answers_state.dart';

@Injectable()
class AnswersCubit extends Cubit<AnswersState> {
  AnswersCubit({required GetSavedQuestionsUseCase getSavedQuestionsUseCase})
    : _getSavedQuestionsUseCase = getSavedQuestionsUseCase,
      super(const AnswersState());

  final GetSavedQuestionsUseCase _getSavedQuestionsUseCase;

  Future<void> doIntent(AnswersEvent event) async => switch (event) {
    LoadAnswersEvent() => _loadAnswers(event.examId),
  };

  Future<void> _loadAnswers(String examId) async {
    emit(state.copyWith(state: BaseStateType.loading));

    final savedQuestions = await _getSavedQuestionsUseCase(examId: examId);

    if (savedQuestions == null || savedQuestions.isEmpty) {
      emit(
        state.copyWith(
          state: BaseStateType.error,
          exception: Exception('No saved questions found'),
        ),
      );
      return;
    }

    final result = _calculateResult(savedQuestions);

    emit(
      state.copyWith(
        state: BaseStateType.success,
        questions: savedQuestions,
        result: result,
      ),
    );
  }

  ExamResultEntity _calculateResult(List<QuestionEntity> questions) {
    int correctAnswers = 0;
    int incorrectAnswers = 0;
    int unansweredQuestions = 0;

    for (final question in questions) {
      final AnswerEntity correctAnswer = question.answers.firstWhere(
        (answer) => answer.key == question.correctAnswer,
        orElse: () => AnswerEntity(key: '', title: ''),
      );
      if (question.answeredQuestion == null ||
          question.answeredQuestion!.isEmpty) {
        unansweredQuestions++;
      } else if (question.answeredQuestion == correctAnswer.title) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }
    }

    final totalQuestions = questions.length;
    final scorePercentage = totalQuestions > 0
        ? (correctAnswers / totalQuestions * 100).round()
        : 0;

    return ExamResultEntity(
      totalQuestions: totalQuestions,
      correctAnswers: correctAnswers,
      incorrectAnswers: incorrectAnswers,
      unansweredQuestions: unansweredQuestions,
      scorePercentage: scorePercentage,
    );
  }
}
