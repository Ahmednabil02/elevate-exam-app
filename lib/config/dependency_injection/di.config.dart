// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;

import '../../feature/exams/api/api_client/exams_api_client.dart' as _i503;
import '../../feature/exams/api/datasources/exams_local_data_source_impl.dart'
    as _i814;
import '../../feature/exams/api/datasources/exams_remote_data_source_impl.dart'
    as _i479;
import '../../feature/exams/data/datasources/exams_local_data_source_contract.dart'
    as _i641;
import '../../feature/exams/data/datasources/exams_remote_data_source_contract.dart'
    as _i494;
import '../../feature/exams/data/repositories/exams_repository_impl.dart'
    as _i616;
import '../../feature/exams/domain/repositories/exams_repository.dart'
    as _i1052;
import '../../feature/exams/domain/use_cases/get_exams_by_subject_use_case.dart'
    as _i441;
import '../../feature/exams/presentation/cubit/exams_cubit.dart' as _i982;
import '../api/app_interceptor.dart' as _i449;
import '../api/dio_module.dart' as _i784;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.singleton<_i361.Dio>(() => dioModule.dio());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => dioModule.secureStorage(),
    );
    gh.lazySingleton<_i361.CancelToken>(() => dioModule.cancelToken());
    gh.lazySingleton<_i161.InternetConnection>(
      () => dioModule.internetConnection(),
    );
    gh.lazySingleton<_i641.ExamsLocalDataSourceContract>(
      () => _i814.ExamsLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i503.ExamsApiClient>(
      () => _i503.ExamsApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i449.AppInterceptors>(
      () => _i449.AppInterceptors(
        dio: gh<_i361.Dio>(),
        fss: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.lazySingleton<_i494.ExamsRemoteDataSourceContract>(
      () => _i479.ExamsRemoteDataSourceImpl(
        apiClient: gh<_i503.ExamsApiClient>(),
      ),
    );
    gh.lazySingleton<_i1052.ExamsRepository>(
      () => _i616.ExamsRepositoryImpl(
        examsRemoteDataSourceContract:
            gh<_i494.ExamsRemoteDataSourceContract>(),
      ),
    );
    gh.lazySingleton<_i441.GetExamsBySubjectUseCase>(
      () => _i441.GetExamsBySubjectUseCase(gh<_i1052.ExamsRepository>()),
    );
    gh.factory<_i982.ExamsCubit>(
      () => _i982.ExamsCubit(
        getExamsBySubjectUseCase: gh<_i441.GetExamsBySubjectUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}
