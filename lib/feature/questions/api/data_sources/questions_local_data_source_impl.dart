import 'package:exam_app/config/database/exam_database.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/feature/questions/api/mapper/local_to_dto.dart';
import 'package:exam_app/feature/questions/data/dataـsources/questions_local_data_source_contract.dart';
import 'package:exam_app/feature/questions/data/models/question_dto.dart';
import 'package:exam_app/feature/questions/data/models/questions_response_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: QuestionsLocalDataSourceContract)
class QuestionsLocalDataSourceImpl implements QuestionsLocalDataSourceContract {
  final ExamDatabase _db;

  QuestionsLocalDataSourceImpl(this._db);

  @override
  Future<void> saveQuestions({required QuestionsResponseDto examData}) async {
    final examId = examData.examId!;

    final companions = LocalToDtoMapper.questionsResponseToCompanions(
      examData: examData,
    );
    bool isNewExam = false;
    try {
      await _db.getExam(examId);
      isNewExam = false;
    } catch (e) {
      isNewExam = true;
    }

    await _db.saveAll(
      examId: examId,
      startExamTime: examData.startExamTime,
      questionsList: companions.questions,
      answersList: companions.answers,
      preserveStartTime: !isNewExam,
    );
  }

  @override
  Future<QuestionsResponseDto> getSavedQuestions({
    required String examId,
  }) async {
    final examData = await _db.getExam(examId);
    if (examData == null) throw Exception(AppStrings.noSavedExamData);

    final questionRows = await _db.getQuestions(examId);
    if (questionRows.isEmpty) throw Exception(AppStrings.noSavedExamData);
    final answersMap = <String, List<Answer>>{};
    for (final questionRow in questionRows) {
      final answerRows = await _db.getAnswersForQuestion(
        questionRow.questionId,
      );
      answersMap[questionRow.questionId] = answerRows;
    }

    final result = LocalToDtoMapper.questionsToDto(
      questionRows: questionRows,
      answersMap: answersMap,
      examId: examId,
      startExamTime: examData.startExamTime,
      endExamTime: examData.endExamTime,
    );
    return result;
  }

  @override
  Future<void> editOneQuestion({
    required String examId,
    required QuestionDto question,
  }) async {
    await _db.updateQuestionAnswer(
      examId: examId,
      questionId: question.id!,
      userAnswer: question.submitAnswer ?? '',
    );
  }

  @override
  Future<void> saveExamEndTime({
    required String examId,
    required DateTime endTime,
  }) async {
    await _db.updateExamEndTime(examId: examId, endTime: endTime);
  }

  @override
  Future<void> clearSavedQuestions({required String examId}) async {
    await _db.deleteExam(examId);
  }
}
