import 'package:exam_app/config/api/api_executer.dart';
import 'package:exam_app/config/base_response/result.dart';
import 'package:injectable/injectable.dart';
import '../../domain/models/subject_entity.dart';
import '../../domain/repositories/subject_repository_contract.dart';
import '../data_sources/subject_remote_data_source.dart';

import 'dart:developer';

@Injectable(as: SubjectRepositoryContract)
class SubjectRepositoryImpl implements SubjectRepositoryContract {
  final SubjectRemoteDataSource _remoteDataSource;

  SubjectRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<SubjectEntity>?>> getSubjects() {
    return executeApi<List<SubjectEntity>?>(() async {
      log("SubjectRepositoryImpl: Fetching subjects...");
      final response = await _remoteDataSource.getSubjects();
      log("SubjectRepositoryImpl: Received response: ${response.message}");
      final subjects = response.subjects?.map((m) => m.toEntity()).toList();
      log("SubjectRepositoryImpl: Converted ${subjects?.length} subjects");
      return subjects;
    });
  }
}
