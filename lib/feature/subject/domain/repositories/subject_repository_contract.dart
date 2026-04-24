import 'package:exam_app/config/base_response/result.dart';
import '../models/subject_entity.dart';

abstract class SubjectRepositoryContract {
  Future<Result<List<SubjectEntity>?>> getSubjects();
}
