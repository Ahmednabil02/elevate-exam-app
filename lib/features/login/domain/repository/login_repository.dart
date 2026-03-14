import '../entities/login_entity.dart';

abstract class LoginRepository {

  Future<String> login(LoginEntity entity);

}