import 'package:drift/drift.dart';
import 'package:exam_app/config/database/exam_database.dart';
import 'package:exam_app/feature/questions/data/models/answer_dto.dart';
import 'package:exam_app/feature/questions/data/models/question_dto.dart';
import 'package:exam_app/feature/questions/data/models/questions_response_dto.dart';

class LocalToDtoMapper {
  static QuestionsResponseDto questionsToDto({
    required List<QuestionTableData> questionRows,
    required Map<String, List<Answer>> answersMap,
    required String examId,
    required DateTime? startExamTime,
    required DateTime? endExamTime,
  }) {
    final questions = questionRows.map((questionRow) {
      final answers = answersMap[questionRow.questionId] ?? [];
      return _questionRowToDto(questionRow, answers);
    }).toList();

    return QuestionsResponseDto(
      questions: questions,
      examId: examId,
      startExamTime: startExamTime,
      endExamTime: endExamTime,
    );
  }

  static QuestionDto _questionRowToDto(
    QuestionTableData questionRow,
    List<Answer> answerRows,
  ) {
    final answers = answerRows.map(_answerRowToDto).toList();

    return QuestionDto(
      id: questionRow.questionId,
      question: questionRow.questionText,
      type: questionRow.questionType,
      correct: questionRow.correctAnswer,
      submitAnswer: questionRow.userAnswer,
      answers: answers,
    );
  }

  static AnswerDto _answerRowToDto(Answer answerRow) {
    return AnswerDto(answer: answerRow.questionText, key: answerRow.answerKey);
  }

  static QuestionTableCompanion questionDtoToCompanion({
    required QuestionDto question,
    required String examId,
  }) {
    return QuestionTableCompanion(
      examId: Value(examId),
      questionId: Value(question.id!),
      questionText: Value(question.question!),
      questionType: Value(question.type!),
      correctAnswer: Value(question.correct!),
      userAnswer: Value(question.submitAnswer),
    );
  }

  static AnswersCompanion answerDtoToCompanion({
    required AnswerDto answer,
    required String questionId,
  }) {
    return AnswersCompanion(
      questionId: Value(questionId),
      questionText: Value(answer.answer ?? ''),
      answerKey: Value(answer.key ?? ''),
    );
  }

  static ({
    List<QuestionTableCompanion> questions,
    List<AnswersCompanion> answers,
  })
  questionsResponseToCompanions({required QuestionsResponseDto examData}) {
    final examId = examData.examId!;
    final questionsList = <QuestionTableCompanion>[];
    final answersList = <AnswersCompanion>[];

    for (final question in examData.questions ?? []) {
      questionsList.add(
        questionDtoToCompanion(question: question, examId: examId),
      );

      for (final answer in question.answers ?? []) {
        answersList.add(
          answerDtoToCompanion(answer: answer, questionId: question.id!),
        );
      }
    }

    return (questions: questionsList, answers: answersList);
  }
}
