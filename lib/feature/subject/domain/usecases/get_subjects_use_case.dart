import 'package:exam_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/config/uses_cases/use_cases.dart';
import 'package:exam_app/feature/subject/domain/models/subject_parm.dart';
import 'package:injectable/injectable.dart';
import '../models/subject_entity.dart';
import '../repositories/subject_repository_contract.dart';

@injectable
class GetSubjectsUseCase
    extends UseCase<BasePaginationEntity<SubjectEntity>, SubjectParm> {
  final SubjectRepositoryContract _repository;

  GetSubjectsUseCase(this._repository);

  @override
  Future<Result<BasePaginationEntity<SubjectEntity>>> call(SubjectParm params) {
    return _repository.getSubjects(params);
  }
}
