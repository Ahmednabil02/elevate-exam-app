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

import '../../feature/login/api/api_client/login_api_client.dart' as _i769;
import '../../feature/login/api/datasources/login_remote_data_source_impl.dart'
    as _i250;
import '../../feature/login/data/datasources/login_remote_data_source_contract.dart'
    as _i385;
import '../../feature/login/data/repositories/login_repository_impl.dart'
    as _i197;
import '../../feature/login/domain/repositories/login_repository.dart' as _i374;
import '../../feature/login/domain/use_cases/login_use_case.dart' as _i46;
import '../../feature/login/presentation/cubit/login_cubit.dart' as _i453;
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
    gh.factory<_i769.LoginApiClient>(
      () => _i769.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i449.AppInterceptors>(
      () => _i449.AppInterceptors(
        dio: gh<_i361.Dio>(),
        fss: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i385.LoginRemoteDataSourceContract>(
      () => _i250.LoginRemoteDataSourceImpl(
        apiClient: gh<_i769.LoginApiClient>(),
      ),
    );
    gh.factory<_i374.LoginRepository>(
      () => _i197.LoginRepositoryImpl(
        remoteDataSource: gh<_i385.LoginRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i46.LoginUseCase>(
      () => _i46.LoginUseCase(repository: gh<_i374.LoginRepository>()),
    );
    gh.factory<_i453.LoginCubit>(
      () => _i453.LoginCubit(loginUseCase: gh<_i46.LoginUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}
