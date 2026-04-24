import 'package:dio/dio.dart';
import 'package:exam_app/config/api/end_points.dart';
import 'package:exam_app/feature/forget_password/domain/entity/forget_password_params.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'forget_password_api_client.g.dart';

@LazySingleton()
@RestApi()
abstract class ForgetPasswordApiClient {
  @factoryMethod
  factory ForgetPasswordApiClient(Dio dio) = _ForgetPasswordApiClient;

  @POST(EndPoints.forgetPassword)
  Future<void> sendForgetPasswordCode(@Body() ForgetPasswordParams request);

  @POST(EndPoints.verifyEmailCode)
  Future<void> verifyForgetPasswordCode(@Body() ForgetPasswordParams request);

  @PUT(EndPoints.resetPassword)
  Future<dynamic> resetPassword(@Body() ForgetPasswordParams request);
}
