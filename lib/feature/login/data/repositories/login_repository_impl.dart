import 'package:exam_app/config/base_response/result.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_data_source_contract.dart';
import '../../api/models/login_request.dart';
import '../../api/models/login_response.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSourceContract remoteDataSource;

  const LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<LoginResponse>> login(LoginRequest request) async {
    return await remoteDataSource.login(request);
  }
}
