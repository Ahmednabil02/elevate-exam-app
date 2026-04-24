import 'package:drift/drift.dart';

class QuestionTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get examId => text()();
  TextColumn get questionId => text()();
  TextColumn get questionText => text()();
  TextColumn get questionType => text()();
  TextColumn get correctAnswer => text()();
  TextColumn get userAnswer => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {examId, questionId},
  ];
}
