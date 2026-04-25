import 'package:exam_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/subject/domain/models/subject_parm.dart';
import '../models/subject_entity.dart';

abstract class SubjectRepositoryContract {
  Future<Result<BasePaginationEntity<SubjectEntity>>> getSubjects(
    SubjectParm params,
  );
}
