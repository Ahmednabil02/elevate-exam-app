import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/api/end_points.dart';
import '../models/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<String> login(LoginModel model);
}

@LazySingleton(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Dio dio;

  LoginRemoteDataSourceImpl(this.dio);

  @override
  Future<String> login(LoginModel model) async {

    final response = await dio.post(
      EndPoints.login,
      data: model.toJson(),
    );

    return response.data["token"];

  }

}