import 'package:exam_app/config/base_response/result.dart';
import 'package:injectable/injectable.dart';
import '../repositories/main_layout_repository.dart';

@injectable
class LogoutUseCase {
  final MainLayoutRepository repository;

  LogoutUseCase(this.repository);

  Future<Result<void>> call() async {
    return await repository.logout();
  }
}
