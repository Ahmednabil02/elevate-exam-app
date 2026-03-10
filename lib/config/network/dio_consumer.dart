import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'api_consumer.dart';
import '../error_handling/exceptions.dart';

@LazySingleton(as: ApiConsumer)
class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client});

  @override
  Future delete(String path, {Object? data, Map<String, dynamic>? queryParameters, bool isFormData = false}) async {
    try {
      final response = await client.delete(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future get(String path, {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future post(String path, {Object? data, Map<String, dynamic>? queryParameters, bool isFormData = false}) async {
    try {
      final response = await client.post(path, data: isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future put(String path, {Object? data, Map<String, dynamic>? queryParameters, bool isFormData = false}) async {
    try {
      final response = await client.put(path, data: isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  dynamic _handleDioError(DioException error) {
    String? message;
    if (error.response?.data is Map) {
      message = error.response?.data['message'];
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException(message: 'Connection timed out');
      case DioExceptionType.unknown:
        throw FetchDataException(message: message ?? 'Error during communication');
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            throw BadRequestException(message: message ?? 'Bad request');
          case 401:
          case 403:
            throw UnauthorizedException(message: message ?? 'Unauthorized');
          case 404:
            throw ServerException(message: message ?? 'Not found');
          case 500:
            throw ServerException(message: message ?? 'Internal server error');
          default:
            throw FetchDataException(message: message ?? 'Error occurred while communicating with server');
        }
      case DioExceptionType.cancel:
        throw const ServerException(message: 'Request cancelled');
      case DioExceptionType.connectionError:
        throw NoInternetException();
      case DioExceptionType.badCertificate:
        throw const ServerException(message: 'Bad certificate');
    }
  }
}
