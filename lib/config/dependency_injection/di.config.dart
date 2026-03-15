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

import '../../feature/sign_up/api/api_client/sign_up_api_client.dart' as _i103;
import '../../feature/sign_up/api/datasources/sign_up_local_data_source_impl.dart'
    as _i448;
import '../../feature/sign_up/api/datasources/sign_up_remote_data_source_impl.dart'
    as _i1011;
import '../../feature/sign_up/data/datasources/sign_up_local_data_source.dart'
    as _i623;
import '../../feature/sign_up/data/datasources/sign_up_remote_data_source.dart'
    as _i716;
import '../../feature/sign_up/data/repositories/sign_up_repository_impl.dart'
    as _i337;
import '../../feature/sign_up/domain/repositories/sign_up_repository_contract.dart'
    as _i919;
import '../../feature/sign_up/domain/usecases/sign_up_user_usecase.dart'
    as _i280;
import '../../feature/sign_up/presentation/cubit/sign_up_cubit.dart' as _i906;
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
    gh.factory<_i103.SignUpApiClient>(
      () => _i103.SignUpApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i449.AppInterceptors>(
      () => _i449.AppInterceptors(
        dio: gh<_i361.Dio>(),
        fss: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i623.SignupLocalDataSourceContract>(
      () => _i448.SignupLocalDataSourceImpl(
        fss: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i906.SignupCubit>(
      () => _i906.SignupCubit(signupUserCase: gh<InvalidType>()),
    );
    gh.factory<_i716.SignupRemoteDataSourceContract>(
      () => _i1011.SignUpRemoteDataSourceImpl(
        homeApiClient: gh<_i103.SignUpApiClient>(),
      ),
    );
    gh.factory<_i919.SignUpRepositoryContract>(
      () => _i337.SignUpRepositoryImpl(
        remoteDataSource: gh<_i716.SignupRemoteDataSourceContract>(),
        localDataSource: gh<_i623.SignupLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i280.SignUpUserUseCase>(
      () => _i280.SignUpUserUseCase(repo: gh<_i919.SignUpRepositoryContract>()),
    );
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}
