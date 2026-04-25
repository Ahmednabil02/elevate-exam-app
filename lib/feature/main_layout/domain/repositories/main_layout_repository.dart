import 'package:exam_app/config/base_response/result.dart';

abstract interface class MainLayoutRepository {
  Future<Result<void>> logout();
}
