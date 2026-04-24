import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/questions/domain/entities/exam_session_entity.dart';
import 'package:exam_app/feature/questions/domain/entities/questions_entity.dart';

abstract interface class QuestionsRepositoryContract {
  Future<Result<List<QuestionEntity>>> getQuestions(String examId);
  Future<void> saveQuestionAnswer({
    required String examId,
    required QuestionEntity question,
  });
  Future<List<QuestionEntity>?> getSavedQuestions({required String examId});
  Future<void> clearSavedQuestions({required String examId});
  Future<ExamSessionEntity?> checkExamSession({
    required String examId,
    required int examDurationInMinutes,
  });
}
