import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_endpoints.dart';

@injectable
class AppInterceptor extends Interceptor {
  final SharedPreferences sharedPreferences;

  AppInterceptor(this.sharedPreferences);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = sharedPreferences.getString(ApiKey.token);
    if (token != null) {
      options.headers['token'] = token;
    }
    super.onRequest(options, handler);
  }
}
