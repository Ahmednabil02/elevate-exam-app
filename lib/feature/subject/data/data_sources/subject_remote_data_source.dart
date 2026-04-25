import 'package:exam_app/feature/subject/domain/models/subject_parm.dart';
import 'package:injectable/injectable.dart';
import '../../api/subject_api_service.dart';
import '../models/subject_model.dart';

abstract class SubjectRemoteDataSource {
  Future<SubjectsResponseModel> getSubjects(SubjectParm params);
}

@Injectable(as: SubjectRemoteDataSource)
class SubjectRemoteDataSourceImpl implements SubjectRemoteDataSource {
  final SubjectApiService _apiService;

  SubjectRemoteDataSourceImpl(this._apiService);

  @override
  Future<SubjectsResponseModel> getSubjects(SubjectParm params) {
    return _apiService.getSubjects(params);
  }
}
