import 'package:exam_app/feature/exams/data/datasources/exams_local_data_source_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExamsLocalDataSourceContract)
class ExamsLocalDataSourceImpl implements ExamsLocalDataSourceContract {}
