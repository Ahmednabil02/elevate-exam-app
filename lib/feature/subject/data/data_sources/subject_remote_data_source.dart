import 'package:injectable/injectable.dart';
import '../../api/subject_api_service.dart';
import '../models/subject_model.dart';

abstract class SubjectRemoteDataSource {
  Future<SubjectsResponseModel> getSubjects();
}

@Injectable(as: SubjectRemoteDataSource)
class SubjectRemoteDataSourceImpl implements SubjectRemoteDataSource {
  final SubjectApiService _apiService;

  SubjectRemoteDataSourceImpl(this._apiService);

  @override
  Future<SubjectsResponseModel> getSubjects() {
    return _apiService.getSubjects();
  }
}
