import 'package:exam_app/config/database/exam_database.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DatabaseModule {
  @lazySingleton
  ExamDatabase get database => ExamDatabase();
}
