import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:exam_app/config/database/tables/answer.dart';
import 'package:exam_app/config/database/tables/exam.dart';
import 'package:exam_app/config/database/tables/question.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'exam_database.g.dart';

@DriftDatabase(tables: [Exam, QuestionTable, Answers])
class ExamDatabase extends _$ExamDatabase {
  ExamDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> saveAll({
    required String examId,
    required DateTime? startExamTime,
    required List<QuestionTableCompanion> questionsList,
    required List<AnswersCompanion> answersList,
    required bool preserveStartTime,
  }) {
    return transaction(() async {
      if (preserveStartTime) {
        // Check if exam exists and preserve its start time
        final existingExam = await getExam(examId);
        final timeToUse = existingExam?.startExamTime ?? startExamTime;

        await into(exam).insertOnConflictUpdate(
          ExamCompanion(examId: Value(examId), startExamTime: Value(timeToUse)),
        );
      } else {
        // Use provided start time (for new exams)
        await into(exam).insertOnConflictUpdate(
          ExamCompanion(
            examId: Value(examId),
            startExamTime: Value(startExamTime),
          ),
        );
      }

      await batch((b) {
        b.insertAllOnConflictUpdate(questionTable, questionsList);
        b.insertAllOnConflictUpdate(answers, answersList);
      });
    });
  }

  Future<int> updateQuestionAnswer({
    required String examId,
    required String questionId,
    required String userAnswer,
  }) {
    return (update(questionTable)..where(
          (t) => t.examId.equals(examId) & t.questionId.equals(questionId),
        ))
        .write(QuestionTableCompanion(userAnswer: Value(userAnswer)));
  }

  Future<ExamData?> getExam(String examId) {
    return (select(
      exam,
    )..where((t) => t.examId.equals(examId))).getSingleOrNull();
  }

  Future<List<QuestionTableData>> getQuestions(String examId) {
    return (select(questionTable)..where((t) => t.examId.equals(examId))).get();
  }

  Future<List<Answer>> getAnswersForQuestion(String questionId) {
    return (select(
      answers,
    )..where((t) => t.questionId.equals(questionId))).get();
  }

  Future<void> deleteExam(String examId) async {
    final questionRows = await getQuestions(examId);
    await transaction(() async {
      for (final q in questionRows) {
        await (delete(
          answers,
        )..where((t) => t.questionId.equals(q.questionId))).go();
      }
      await (delete(questionTable)..where((t) => t.examId.equals(examId))).go();
      await (delete(exam)..where((t) => t.examId.equals(examId))).go();
    });
  }

  Future<void> clearAll() {
    return transaction(() async {
      await delete(answers).go();
      await delete(questionTable).go();
      await delete(exam).go();
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'exam_app.db'));
    return NativeDatabase(file);
  });
}
