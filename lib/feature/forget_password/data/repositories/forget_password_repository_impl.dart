import 'dart:developer';

import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/forget_password/domain/entity/forget_password_params.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/forget_password_repository.dart';
import '../datasources/forget_password_remote_data_source_contract.dart';

@Injectable(as: ForgetPasswordRepository)
class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository {
  final ForgetPasswordRemoteDataSourceContract remoteDataSource;

  const ForgetPasswordRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<void>> sendForgetPasswordCode(
    ForgetPasswordParams params,
  ) async {
    final response = await remoteDataSource.sendForgetPasswordCode(params);
    switch (response) {
      case Success():
         return Success(data: response.data);
      case Error():
        return Error(exception: response.exception);
    }
  }

  @override
  Future<Result<void>> verifyForgetPasswordCode(
    ForgetPasswordParams params,
  ) async {
    final response = await remoteDataSource.verifyForgetPasswordCode(params);
    switch (response) {
      case Success():
        return Success(data: response.data);
      case Error():
        return Error(exception: response.exception);
    }
  }

  @override
  Future<Result<void>> resetPassword(ForgetPasswordParams params) async {
    final response = await remoteDataSource.resetPassword(params);
    switch (response) {
      case Success():
        return Success(data: response.data);
      case Error():
        return Error(exception: response.exception);
    }
  }
}
