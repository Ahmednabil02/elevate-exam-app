import '../entities/login_entity.dart';
import '../repository/login_repository.dart';

class LoginUseCase {

  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<String> call(LoginEntity entity) {

    return repository.login(entity);

  }

}