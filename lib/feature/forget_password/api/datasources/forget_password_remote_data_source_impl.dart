import 'dart:developer';

import 'package:exam_app/config/api/api_executer.dart';
import 'package:exam_app/config/api/end_points.dart';
import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/forget_password/domain/entity/forget_password_params.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../data/datasources/forget_password_remote_data_source_contract.dart';
import '../api_client/forget_password_api_client.dart';
import '../models/reset_password_response.dart';

@Injectable(as: ForgetPasswordRemoteDataSourceContract)
class ForgetPasswordRemoteDataSourceImpl
    implements ForgetPasswordRemoteDataSourceContract {
  final ForgetPasswordApiClient apiClient;
  final FlutterSecureStorage fss;

  const ForgetPasswordRemoteDataSourceImpl({
    required this.apiClient,
    required this.fss,
  });

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
  Future<Result<void>> resetPassword(ForgetPasswordParams params) async {
    return await executeApi<void>(() async {
      final response = await apiClient.resetPassword(params);
      final resetResponse = ResetPasswordResponse.fromJson(
        response as Map<String, dynamic>,
      );

      await fss.write(key: Apikeys.accessToken, value: resetResponse.token);

      log("Token saved successfully: ${resetResponse.token}");
    });
  }
}
