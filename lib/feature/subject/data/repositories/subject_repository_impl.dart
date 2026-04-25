import 'package:exam_app/config/api/api_execute.dart';
import 'package:exam_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/subject/domain/models/subject_parm.dart';
import 'package:injectable/injectable.dart';
import '../../domain/models/subject_entity.dart';
import '../../domain/repositories/subject_repository_contract.dart';
import '../data_sources/subject_remote_data_source.dart';

@Injectable(as: SubjectRepositoryContract)
class SubjectRepositoryImpl implements SubjectRepositoryContract {
  final SubjectRemoteDataSource _remoteDataSource;

  SubjectRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<BasePaginationEntity<SubjectEntity>>> getSubjects(
    SubjectParm params,
  ) {
    return executeApi<BasePaginationEntity<SubjectEntity>>(() async {
      final response = await _remoteDataSource.getSubjects(params);
      return response.toSubjectEntity();
    });
  }
}
