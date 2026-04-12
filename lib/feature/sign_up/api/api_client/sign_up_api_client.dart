import 'package:dio/dio.dart';
import 'package:exam_app/config/api/end_points.dart';
import 'package:exam_app/feature/sign_up/data/models/sign_up_post_model/sign_up_post_dto.dart';
import 'package:exam_app/feature/sign_up/data/models/sign_up_response/sign_up_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'sign_up_api_client.g.dart';

@LazySingleton()
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class SignUpApiClient {
  @factoryMethod
  factory SignUpApiClient(Dio dio) = _SignUpApiClient;

  @POST(EndPoints.signupEndpoint)
  Future<SignUpResponse> signupUser(@Body() SignUpRequestDto signUpModel);
}
