import 'dart:developer';

import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/questions/data/dataـsources/questions_local_data_source_contract.dart';
import 'package:exam_app/feature/questions/data/dataـsources/questions_remote_data_source_contract.dart';
import 'package:exam_app/feature/questions/data/models/question_dto.dart';
import 'package:exam_app/feature/questions/domain/entities/exam_session_entity.dart';
import 'package:exam_app/feature/questions/domain/entities/questions_entity.dart';
import 'package:exam_app/feature/questions/domain/repositories/questions_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: QuestionsRepositoryContract)
class QuestionsRepositoryImpl implements QuestionsRepositoryContract {
  final QuestionsRemoteDataSourceContract questionsRemoteDataSourceContract;
  final QuestionsLocalDataSourceContract questionsLocalDataSourceContract;

  QuestionsRepositoryImpl({
    required this.questionsRemoteDataSourceContract,
    required this.questionsLocalDataSourceContract,
  });

  @override
  Future<Result<List<QuestionEntity>>> getQuestions(String examId) async {
    try {
      await questionsLocalDataSourceContract.clearSavedQuestions(
        examId: examId,
      );
    } catch (e) {
      log('🔧 Repository: Error clearing local questions: $e');
    }

    final result = await questionsRemoteDataSourceContract.getQuestions(examId);
    return result.when(
      success: (data) async {
        if (data?.questions != null && data!.questions!.isNotEmpty) {
          final examData = data.copyWith(
            examId: examId,
            startExamTime: DateTime.now(),
          );

          await questionsLocalDataSourceContract.saveQuestions(
            examData: examData,
          );
        }
        return Success(data: data?.toQuestionEntity().data ?? []);
      },
      error: (exception) => Error(exception: exception),
    );
  }

  @override
  Future<void> saveQuestionAnswer({
    required String examId,
    required QuestionEntity question,
  }) async {
    final questionDto = QuestionDto(
      id: question.id,
      question: question.questionTitle,
      correct: question.correctAnswer,
      type: question.type,
      submitAnswer: question.answeredQuestion,
    );

    await questionsLocalDataSourceContract.editOneQuestion(
      examId: examId,
      question: questionDto,
    );
  }

  @override
  Future<List<QuestionEntity>?> getSavedQuestions({
    required String examId,
  }) async {
    try {
      final responseDto = await questionsLocalDataSourceContract
          .getSavedQuestions(examId: examId);
      final entities = responseDto.questions?.map((dto) {
        return dto.toEntity();
      }).toList();
      if (entities != null && entities.isNotEmpty) {}

      return entities;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearSavedQuestions({required String examId}) async {
    await questionsLocalDataSourceContract.clearSavedQuestions(examId: examId);
  }

  @override
  Future<ExamSessionEntity?> checkExamSession({
    required String examId,
    required int examDurationInMinutes,
  }) async {
    try {
      final savedData = await questionsLocalDataSourceContract
          .getSavedQuestions(examId: examId);

      if (savedData.startExamTime == null || savedData.questions == null) {
        return null;
      }

      final startTime = savedData.startExamTime!;
      final now = DateTime.now();
      final endTime = startTime.add(Duration(minutes: examDurationInMinutes));
      final isExpired = now.isAfter(endTime);

      return ExamSessionEntity(
        examId: examId,
        startTime: startTime,
        durationInMinutes: examDurationInMinutes,
        questions: savedData.questions!.map((dto) => dto.toEntity()).toList(),
        status: isExpired
            ? ExamSessionStatus.expired
            : ExamSessionStatus.inProgress,
      );
    } catch (e) {
      return null;
    }
  }
}
