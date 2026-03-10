import 'package:dio/dio.dart';
 import 'package:exam_app/config/error_handling/failures.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../base_response/result.dart';
import '../dependency_injection/di.dart';

Future<Result<T>> executeApi<T>(Future<T> Function() apiCall) async {
  if (!await getIt.get<InternetConnection>().hasInternetAccess) {
    return Error(
      exception: NetworkFailures(errorMessage: AppStrings.noInternet),
    );
  }
  try {
    var result = await apiCall();
    return Success<T>(data: result);
  } on DioException catch (ex) {
    return Error<T>(
      exception: ServerFailure.fromDioException(dioException: ex),
    );
  } on Exception catch (ex) {
    return Error<T>(exception: ex);
  }
}
