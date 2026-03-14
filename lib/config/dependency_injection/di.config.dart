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

import '../../features/login/data/datasource/login_remote_datasource.dart'
    as _i37;
import '../../features/login/data/repository/login_repository_impl.dart'
    as _i738;
import '../../features/login/domain/repository/login_repository.dart' as _i312;
import '../../features/login/domain/usecases/login_usecase.dart' as _i420;
import '../../features/login/presentation/cubit/login_cubit.dart' as _i147;
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
    gh.lazySingleton<_i37.LoginRemoteDataSource>(
      () => _i37.LoginRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.singleton<_i449.AppInterceptors>(
      () => _i449.AppInterceptors(
        dio: gh<_i361.Dio>(),
        fss: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.lazySingleton<_i312.LoginRepository>(
      () => _i738.LoginRepositoryImpl(gh<_i37.LoginRemoteDataSource>()),
    );
    gh.lazySingleton<_i420.LoginUseCase>(
      () => _i420.LoginUseCase(gh<_i312.LoginRepository>()),
    );
    gh.factory<_i147.LoginCubit>(
      () => _i147.LoginCubit(gh<_i420.LoginUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}
