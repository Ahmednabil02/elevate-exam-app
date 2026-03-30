import 'package:exam_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/config/uses_cases/use_cases.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exams/domain/entities/exams_parms.dart';
import 'package:exam_app/feature/exams/domain/repositories/exams_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetExamsBySubjectUseCase extends UseCase<BasePaginationEntity<ExamEntity>, ExamParms> {
  final ExamsRepository repository;

  GetExamsBySubjectUseCase(this.repository);

  @override
  Future<Result<BasePaginationEntity<ExamEntity>>> call(ExamParms params) {
    return repository.getExams(params: params);
  }
}
