import 'package:dio/dio.dart';
import 'package:exam_app/config/api/end_points.dart';
import 'package:exam_app/feature/subject/domain/models/subject_parm.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../data/models/subject_model.dart';
part 'subject_api_service.g.dart';

@injectable
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class SubjectApiService {
  @factoryMethod
  factory SubjectApiService(Dio dio) = _SubjectApiService;

  @GET(EndPoints.subjects)
  Future<SubjectsResponseModel> getSubjects(@Queries() SubjectParm params);
}
