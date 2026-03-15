import 'package:exam_app/config/base_response/result.dart';
import '../../api/models/login_request.dart';
import '../../api/models/login_response.dart';

abstract class LoginRemoteDataSourceContract {
  Future<Result<LoginResponse>> login(LoginRequest request);
}
