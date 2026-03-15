import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/forget_password/domain/entity/forget_password_params.dart';

abstract class ForgetPasswordRepository {
  Future<Result<void>> sendForgetPasswordCode(ForgetPasswordParams params);

  Future<Result<void>> verifyForgetPasswordCode(ForgetPasswordParams params);

  Future<Result<void>> resetPassword(ForgetPasswordParams params);
}
