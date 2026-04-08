import 'package:exam_app/config/base_response/result.dart';
import 'package:injectable/injectable.dart';
import '../models/subject_entity.dart';
import '../repositories/subject_repository_contract.dart';

@injectable
class GetSubjectsUseCase {
  final SubjectRepositoryContract _repository;

  GetSubjectsUseCase(this._repository);

  Future<Result<List<SubjectEntity>?>> execute() {
    return _repository.getSubjects();
  }
}
