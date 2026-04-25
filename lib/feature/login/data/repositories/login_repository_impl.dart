import 'package:exam_app/config/base_response/result.dart';
import 'package:injectable/injectable.dart';
import '../../../sign_up/data/data_sources/sign_up_local_data_source.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_data_source_contract.dart';
import '../../api/models/login_request.dart';
import '../../api/models/login_response.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final SignupLocalDataSourceContract localDataSource;

  final LoginRemoteDataSourceContract remoteDataSource;
  //gaser454554@gmail.com
  const LoginRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<LoginResponse>> login(LoginRequest request) async {
    final response = await remoteDataSource.login(request);

    switch (response) {
      case Success<LoginResponse>():
        await localDataSource.saveUserToken(response.data?.token ?? "");
        return Success<LoginResponse>(data: response.data);
      case Error<LoginResponse>():
        return Error<LoginResponse>(exception: response.exception);
    }
  }
}
