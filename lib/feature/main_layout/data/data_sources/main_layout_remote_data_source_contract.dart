import 'package:exam_app/config/base_response/result.dart';

abstract interface class MainLayoutRemoteDataSourceContract {
  Future<Result<void>> logout();
}
