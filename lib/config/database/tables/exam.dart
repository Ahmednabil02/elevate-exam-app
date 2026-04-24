import 'package:drift/drift.dart';

class Exam extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get examId => text().unique()();
  DateTimeColumn get startExamTime => dateTime().nullable()();
  DateTimeColumn get endExamTime => dateTime().nullable()();
}
