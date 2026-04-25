import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:exam_app/feature/main_layout/data/data_sources/main_layout_remote_data_source_contract.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/main_layout_repository.dart';

@Injectable(as: MainLayoutRepository)
class MainLayoutRepositoryImpl implements MainLayoutRepository {
  final MainLayoutRemoteDataSourceContract remoteDataSource;

  const MainLayoutRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<void>> logout() async {
    final response = await remoteDataSource.logout();
    switch (response) {
      case Success<void>():
        await getIt<FlutterSecureStorage>().deleteAll();
        return Success<void>(data: response.data);
      case Error<void>():
        return Error<void>(exception: response.exception);
    }
  }
}
