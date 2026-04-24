import 'package:dio/dio.dart';
import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'end_points.dart';
import 'status_code.dart';

@singleton
class AppInterceptors extends Interceptor {
  final Dio dio;
  final FlutterSecureStorage fss;

  AppInterceptors({required this.dio, required this.fss});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.cancelToken = getIt<CancelToken>();
    // String? authToken = await fss.read(key: APIkeys.accessToken);
    String? authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5ZTczZDQyMDRkYTBkNGNmNTU2Y2MzZSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzc2NzYyMjM4fQ.t8UnlTY9c3GU1-BlSnK8cBD8mmgoWRni3NRSFH7oTRs";
    if (authToken != null && authToken.isNotEmpty) {
      // options.headers['Authorization'] = 'Bearer $authToken';
      options.headers["token"] = authToken;
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ToDo
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint("err.response?.statusCode ${err.response?.statusCode}");
    if (err.response?.statusCode == StatusCode.expiredToken) {
      //todo clear user data
    }
    super.onError(err, handler);
  }
}
