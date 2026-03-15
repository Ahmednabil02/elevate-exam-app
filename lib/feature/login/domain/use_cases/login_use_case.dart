import 'package:exam_app/config/base_response/result.dart';
import 'package:injectable/injectable.dart';
import '../repositories/login_repository.dart';
import '../../api/models/login_request.dart';
import '../../api/models/login_response.dart';

@injectable
class LoginUseCase {
  final LoginRepository repository;

  const LoginUseCase({required this.repository});

  Future<Result<LoginResponse>> call(LoginRequest request) async {
    return await repository.login(request);
  }
}
