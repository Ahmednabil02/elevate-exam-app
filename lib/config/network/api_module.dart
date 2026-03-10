import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_interceptor.dart';
import 'api_endpoints.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class ApiModule {
  @preResolve
  Future<SharedPreferences> get sharedPreferences => SharedPreferences.getInstance();

  @lazySingleton
  InternetConnection get internetConnection => InternetConnection();

  @lazySingleton
  Dio getDio(AppInterceptor appInterceptor) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );
    
    dio.interceptors.add(appInterceptor);
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ));
    
    return dio;
  }
}
