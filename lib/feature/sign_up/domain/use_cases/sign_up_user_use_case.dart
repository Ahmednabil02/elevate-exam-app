import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/config/uses_cases/use_cases.dart';
import 'package:exam_app/feature/sign_up/domain/models/sign_up_post_entity.dart';
import 'package:exam_app/feature/sign_up/domain/models/user_entity.dart';
import 'package:exam_app/feature/sign_up/domain/repositories/sign_up_repository_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpUserUseCase extends UseCase<UserEntity, SignUpPostEntity> {
  final SignUpRepositoryContract repo;

  const SignUpUserUseCase({required this.repo});
  @override
  Future<Result<UserEntity>> call(SignUpPostEntity data) =>
      repo.signUpUser(data);
}
