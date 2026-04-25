import 'package:dio/dio.dart';
import 'package:exam_app/config/api/end_points.dart';
import 'package:exam_app/feature/questions/data/models/questions_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'questions_api_client.g.dart';

@LazySingleton()
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class QuestionsApiClient {
  @factoryMethod
  factory QuestionsApiClient(Dio dio) => _QuestionsApiClient(dio);

  @GET(EndPoints.questions)
  Future<QuestionsResponseDto> getQuestions(@Query(APIkeys.exam) String examId);
}
