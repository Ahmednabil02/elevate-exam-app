import 'package:dio/dio.dart';
import 'package:exam_app/config/api/end_points.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

part 'login_api_client.g.dart';

@injectable
@RestApi()
abstract class LoginApiClient {
  @factoryMethod
  factory LoginApiClient(Dio dio) = _LoginApiClient;

  @POST(EndPoints.login)
  Future<LoginResponse> login(@Body() LoginRequest request);
}
