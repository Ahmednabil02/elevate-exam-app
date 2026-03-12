import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/config/uses_cases/use_cases.dart';
import 'package:exam_app/feature/forget_password/domain/entity/forget_password_params.dart';
import 'package:injectable/injectable.dart';

import '../repositories/forget_password_repository.dart';

@injectable
class VerifyOtpUseCase  extends UseCase<void, ForgetPasswordParams> {
  final ForgetPasswordRepository repository;

  const VerifyOtpUseCase(this.repository);

  @override
  Future<Result<void>> call(ForgetPasswordParams params) {
    return repository.verifyForgetPasswordCode(params);
  }
}
