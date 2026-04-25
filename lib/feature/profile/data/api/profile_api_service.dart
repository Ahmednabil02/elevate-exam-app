import 'package:dio/dio.dart';
import 'package:exam_app/config/api/end_points.dart';
import 'package:exam_app/feature/profile/data/models/profile_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
@injectable
abstract class ProfileApiService {
  @factoryMethod
  factory ProfileApiService(Dio dio) = _ProfileApiService;

  @GET(EndPoints.getProfileData)
  Future<ProfileModelResponse> getProfileData();

  @PUT(EndPoints.updateProfile)
  Future<ProfileModel> updateProfile(@Body() ProfileModel profile);

  @PATCH(EndPoints.changePassword)
  Future<String> changePassword(@Body() Map<String, dynamic> body);
}

//comment
