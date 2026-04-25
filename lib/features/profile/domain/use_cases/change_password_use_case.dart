import 'package:equatable/equatable.dart';
import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/config/uses_cases/use_cases.dart';
import 'package:injectable/injectable.dart';
import '../repositories/profile_repository.dart';

@injectable
class ChangePasswordUseCase extends UseCase<String, ChangePasswordParams> {
  final ProfileRepository _repository;

  const ChangePasswordUseCase(this._repository);

  @override
  Future<Result<String>> call(ChangePasswordParams params) async {
    return _repository.changePassword(
      params.currentPassword,
      params.newPassword,
      params.confirmPassword,
    );
  }
}

class ChangePasswordParams extends Equatable {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordParams({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword, confirmPassword];
}
