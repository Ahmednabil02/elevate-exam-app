import 'package:dio/dio.dart';
import 'package:exam_app/config/api/end_points.dart';
import 'package:exam_app/feature/exams/data/models/exams_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'exams_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class ExamsApiClient {
  @factoryMethod
  factory ExamsApiClient(Dio dio) => _ExamsApiClient(dio);

  @GET(EndPoints.exams)
  Future<ExamsResponseDto> getExams(@Queries() Map<String, dynamic> queries);
}
