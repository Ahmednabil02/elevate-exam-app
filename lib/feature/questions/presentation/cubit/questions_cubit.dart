import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/config/base_state/state_types.dart';
import 'package:exam_app/feature/questions/domain/entities/exam_session_entity.dart';
import 'package:exam_app/feature/questions/domain/entities/questions_entity.dart';
import 'package:exam_app/feature/questions/domain/use_cases/check_exam_session_use_case.dart';
import 'package:exam_app/feature/questions/domain/use_cases/clear_exam_session_use_case.dart';
import 'package:exam_app/feature/questions/domain/use_cases/get_questions_use_case.dart';
import 'package:exam_app/feature/questions/domain/use_cases/get_saved_questions_use_case.dart';
import 'package:exam_app/feature/questions/domain/use_cases/save_answer_use_case.dart';
import 'package:exam_app/feature/questions/domain/use_cases/save_exam_end_time_use_case.dart';
import 'package:exam_app/feature/questions/presentation/cubit/questions_events.dart';
import 'package:injectable/injectable.dart';

part 'questions_state.dart';

@Injectable()
class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit({
    required GetQuestionsUseCase questionsUseCase,
    required CheckExamSessionUseCase checkExamSessionUseCase,
    required GetSavedQuestionsUseCase resumeExamUseCase,
    required ClearExamSessionUseCase clearExamSessionUseCase,
    required SaveAnswerUseCase saveAnswerUseCase,
    required SaveExamEndTimeUseCase saveExamEndTimeUseCase,
  }) : _getQuestionsUseCase = questionsUseCase,
       _checkExamSessionUseCase = checkExamSessionUseCase,
       _resumeExamUseCase = resumeExamUseCase,
       _clearExamSessionUseCase = clearExamSessionUseCase,
       _saveAnswerUseCase = saveAnswerUseCase,
       _saveExamEndTimeUseCase = saveExamEndTimeUseCase,
       super(const QuestionsState(currentPage: 0));

  Future<void> doIntent(QuestionsEvent event) async => switch (event) {
    AnswerSelectedEvent() => _selectAnswer(event.index, event.selectAnswer),
    GetQuestionsEvent() => _getQuestions(
      event.examId,
      event.examDurationInMinutes,
    ),
    QuestionChanged() => _changeQuestion(event.currentPage),
    CheckExamSessionEvent() => _checkExamSession(
      event.examId,
      event.examDurationInMinutes,
    ),
    ResumeExamEvent() => _resumeExam(event.examId),
    ClearExpiredExamEvent() => _clearExpiredExam(event.examId),
    SubmitExamEvent() => _submitExam(event.examId),
  };

  final GetQuestionsUseCase _getQuestionsUseCase;
  final CheckExamSessionUseCase _checkExamSessionUseCase;
  final GetSavedQuestionsUseCase _resumeExamUseCase;
  final ClearExamSessionUseCase _clearExamSessionUseCase;
  final SaveAnswerUseCase _saveAnswerUseCase;
  final SaveExamEndTimeUseCase _saveExamEndTimeUseCase;

  Future<void> _selectAnswer(int index, String answer) async {
    final currentData = List<QuestionEntity>.from(state.data ?? []);
    final updatedQuestion = currentData[index].copyWith(
      answeredQuestion: answer,
    );

    currentData[index] = updatedQuestion;
    emit(state.copyWith(state: BaseStateType.success, data: currentData));

    await _autoSaveAnswer(index, updatedQuestion);
  }

  Future<void> _autoSaveAnswer(int index, QuestionEntity question) async {
    final examId = state.examSession?.examId;
    if (examId != null) {
      try {
        await _saveAnswerUseCase(examId: examId, question: question);
      } catch (e) {
        log('🔧 Error auto-saving answer for question index $index: $e');
      }
    }
  }

  void _changeQuestion(int currentPage) {
    emit(state.copyWith(currentPage: currentPage));
  }

  Future<void> _checkExamSession(
    String examId,
    int examDurationInMinutes,
  ) async {
    emit(state.copyWith(state: BaseStateType.loading));

    final session = await _checkExamSessionUseCase(
      examId: examId,
      examDurationInMinutes: examDurationInMinutes,
    );

    log('🔍 _checkExamSession: session = $session');
    log('🔍 _checkExamSession: session.status = ${session?.status}');
    log('🔍 _checkExamSession: session.endExamTime = ${session?.endExamTime}');

    if (session == null) {
      log('🔍 _checkExamSession: No session, emitting initial state');
      emit(state.copyWith(state: BaseStateType.initial, examSession: null));
    } else if (session.status == ExamSessionStatus.completed) {
      log(
        '🔍 _checkExamSession: Exam completed, emitting initial state with session',
      );
      emit(state.copyWith(state: BaseStateType.initial, examSession: session));
    } else if (session.status == ExamSessionStatus.expired) {
      log(
        '🔍 _checkExamSession: Exam expired, emitting initial state with session',
      );
      emit(state.copyWith(state: BaseStateType.initial, examSession: session));
    } else {
      log(
        '🔍 _checkExamSession: Exam in progress, emitting initial state with session',
      );
      emit(state.copyWith(state: BaseStateType.initial, examSession: session));
    }
  }

  Future<void> _resumeExam(String examId) async {
    emit(state.copyWith(state: BaseStateType.loading));

    final savedQuestions = await _resumeExamUseCase(examId: examId);

    if (savedQuestions == null || savedQuestions.isEmpty) {
      return emit(state.copyWith(state: BaseStateType.error));
    }

    emit(
      state.copyWith(
        state: BaseStateType.success,
        data: savedQuestions,
        examStartTime: state.examSession?.startTime,
        examDurationInMinutes: state.examSession?.durationInMinutes,
      ),
    );
  }

  Future<void> _clearExpiredExam(String examId) async {
    await _clearExamSessionUseCase(examId: examId);
    emit(
      state.copyWith(
        examSession: null,
        examStartTime: null,
        examDurationInMinutes: null,
      ),
    );
  }

  Future<void> _getQuestions(String examId, int examDurationInMinutes) async {
    emit(
      state.copyWith(
        state: BaseStateType.loading,
        isDone: false,
        currentPage: 0,
      ),
    );

    final response = await _getQuestionsUseCase.call(examId);

    switch (response) {
      case Success<List<QuestionEntity>>():
        final startTime = DateTime.now();
        emit(
          state.copyWith(
            state: BaseStateType.success,
            data: response.data,
            examStartTime: startTime,
            examDurationInMinutes: examDurationInMinutes,
            examSession: ExamSessionEntity(
              examId: examId,
              startTime: startTime,
              durationInMinutes: examDurationInMinutes,
              questions: response.data ?? [],
              status: ExamSessionStatus.inProgress,
            ),
          ),
        );
      case Error<List<QuestionEntity>>():
        emit(state.copyWith(state: BaseStateType.error));
    }
  }

  Future<void> _submitExam(String examId) async {
    try {
      log('📝 Submitting exam: $examId');

      final endTime = DateTime.now();
      await _saveExamEndTimeUseCase(examId: examId, endTime: endTime);

      emit(
        const QuestionsState(
          currentPage: 0,
          state: BaseStateType.initial,
          data: null,
          examSession: null,
          examStartTime: null,
          examDurationInMinutes: null,
        ),
      );

      log('✅ Exam submitted successfully');
    } catch (e) {
      log('❌ Error submitting exam: $e');
      // Even if there's an error, we still clear the state
      emit(
        const QuestionsState(
          currentPage: 0,
          state: BaseStateType.initial,
          data: null,
          examSession: null,
          examStartTime: null,
          examDurationInMinutes: null,
        ),
      );
    }
  }
}
