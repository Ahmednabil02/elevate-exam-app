import 'package:injectable/injectable.dart';
import '../entities/login_entity.dart';
import '../repository/login_repository.dart';

@lazySingleton
class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<String> call(LoginEntity entity) {

    return repository.login(entity);

  }

}