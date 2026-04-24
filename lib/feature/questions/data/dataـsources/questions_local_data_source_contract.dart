import 'package:exam_app/feature/questions/data/models/question_dto.dart';
import 'package:exam_app/feature/questions/data/models/questions_response_dto.dart';

abstract interface class QuestionsLocalDataSourceContract {
  Future<void> saveQuestions({required QuestionsResponseDto examData});

  Future<QuestionsResponseDto> getSavedQuestions({required String examId});

  Future<void> editOneQuestion({
    required String examId,
    required QuestionDto question,
  });

  Future<void> saveExamEndTime({
    required String examId,
    required DateTime endTime,
  });

  Future<void> clearSavedQuestions({required String examId});
}
