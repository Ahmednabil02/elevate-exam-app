import 'dart:developer';

import 'package:exam_app/config/api/api_execute.dart';
import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/forget_password/domain/entity/forget_password_params.dart';
import 'package:injectable/injectable.dart';

import '../../data/datasources/forget_password_remote_data_source_contract.dart';
import '../api_client/forget_password_api_client.dart';
import '../models/reset_password_response.dart';

@Injectable(as: ForgetPasswordRemoteDataSourceContract)
class ForgetPasswordRemoteDataSourceImpl
    implements ForgetPasswordRemoteDataSourceContract {
  final ForgetPasswordApiClient apiClient;

  const ForgetPasswordRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Result<void>> sendForgetPasswordCode(
    ForgetPasswordParams params,
  ) async {
    return await executeApi<void>(() {
      log("Sending forget password code for email: ${params.email}");
      return apiClient.sendForgetPasswordCode(params);
    });
  }

  @override
  Future<Result<void>> verifyForgetPasswordCode(
    ForgetPasswordParams params,
  ) async {
    return await executeApi<void>(() {
      return apiClient.verifyForgetPasswordCode(params);
    });
  }

  @override
  Future<Result<ResetPasswordResponse?>> resetPassword(
    ForgetPasswordParams params,
  ) async {
    return await executeApi<ResetPasswordResponse?>(() async {
      final response = await apiClient.resetPassword(params);

      // Check if response is a Map before casting
      if (response is Map<String, dynamic>) {
        final resetResponse = ResetPasswordResponse.fromJson(response);
        log("Password reset successful, token received");
        return resetResponse;
      }

      log("Unexpected response type: ${response.runtimeType}");
      return null;
    });
  }
}
