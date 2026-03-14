import 'package:dio/dio.dart';
import '../models/login_model.dart';

abstract class LoginRemoteDataSource {

  Future<String> login(LoginModel model);

}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {

  final Dio dio;

  LoginRemoteDataSourceImpl(this.dio);

  @override
  Future<String> login(LoginModel model) async {

    final response = await dio.post(
      "/auth/login",
      data: model.toJson(),
    );

    return response.data["token"];

  }

}