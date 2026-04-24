import 'package:drift/drift.dart';

class Answers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get questionId => text()();
  TextColumn get questionText => text()();
  TextColumn get answerKey => text()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {questionId, answerKey},
  ];
}
