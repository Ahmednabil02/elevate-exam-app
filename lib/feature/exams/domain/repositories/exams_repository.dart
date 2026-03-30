import 'package:exam_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exams/domain/entities/exams_parms.dart';

abstract class ExamsRepository {
  Future<Result<BasePaginationEntity<ExamEntity>>> getExams({
    required ExamParms params,
  });
}
