import 'package:exam_app/config/api/api_execute.dart';
import 'package:exam_app/config/base_response/result.dart';
import 'package:injectable/injectable.dart';
import '../../data/datasources/login_remote_data_source_contract.dart';
import '../api_client/login_api_client.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

@Injectable(as: LoginRemoteDataSourceContract)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSourceContract {
  final LoginApiClient apiClient;

  const LoginRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Result<LoginResponse>> login(LoginRequest request) async {
    return await executeApi<LoginResponse>(() {
      return apiClient.login(request);
    });
  }
}
