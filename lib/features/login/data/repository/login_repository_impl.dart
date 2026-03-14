import '../../domain/entities/login_entity.dart';
import '../../domain/repository/login_repository.dart';
import '../datasource/login_remote_datasource.dart';
import '../models/login_model.dart';

class LoginRepositoryImpl implements LoginRepository {

  final LoginRemoteDataSource remote;

  LoginRepositoryImpl(this.remote);

  @override
  Future<String> login(LoginEntity entity) async {

    final model = LoginModel(
      email: entity.email,
      password: entity.password,
    );

    return await remote.login(model);

  }

}