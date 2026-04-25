import 'package:dio/dio.dart';
import 'package:exam_app/config/api/end_points.dart';
import 'package:retrofit/retrofit.dart';

import 'package:injectable/injectable.dart';

part 'main_layout_api_client.g.dart';

@injectable
@RestApi()
abstract class MainLayoutApiClient {
  @factoryMethod
  factory MainLayoutApiClient(Dio dio) = _MainLayoutApiClient;

  @GET(EndPoints.logout)
  Future<void> logout();
}
