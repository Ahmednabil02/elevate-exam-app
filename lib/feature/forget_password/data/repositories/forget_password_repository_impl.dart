import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/core/data/datasources/auth_local_data_source.dart';
import 'package:exam_app/feature/forget_password/domain/entity/forget_password_params.dart';
import 'package:injectable/injectable.dart';

import '../../api/models/reset_password_response.dart';
import '../../domain/repositories/forget_password_repository.dart';
import '../datasources/forget_password_remote_data_source_contract.dart';

@Injectable(as: ForgetPasswordRepository)
class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository {
  final ForgetPasswordRemoteDataSourceContract remoteDataSource;
  final AuthLocalDataSourceContract localDataSource;

  const ForgetPasswordRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<void>> sendForgetPasswordCode(
    ForgetPasswordParams params,
  ) async {
    final response = await remoteDataSource.sendForgetPasswordCode(params);
    switch (response) {
      case Success<void>():
        return Success<void>(data: response.data);
      case Error<void>():
        return Error<void>(exception: response.exception);
    }
  }

  @override
  Future<Result<void>> verifyForgetPasswordCode(
    ForgetPasswordParams params,
  ) async {
    final response = await remoteDataSource.verifyForgetPasswordCode(params);
    switch (response) {
      case Success<void>():
        return Success<void>(data: response.data);
      case Error<void>():
        return Error<void>(exception: response.exception);
    }
  }

  @override
  Future<Result<void>> resetPassword(ForgetPasswordParams params) async {
    final response = await remoteDataSource.resetPassword(params);
    switch (response) {
      case Success<ResetPasswordResponse?>():
        // Save token to local storage
        final token = response.data?.token;
        if (token != null) {
          await localDataSource.saveUserToken(token);
        }
        return Success<void>(data: null);
      case Error<ResetPasswordResponse?>():
        return Error<void>(exception: response.exception);
    }
  }
}
