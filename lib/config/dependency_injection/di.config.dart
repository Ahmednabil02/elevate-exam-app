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

import '../../feature/forget_password/api/api_client/forget_password_api_client.dart'
    as _i130;
import '../../feature/forget_password/api/datasources/forget_password_remote_data_source_impl.dart'
    as _i243;
import '../../feature/forget_password/data/datasources/forget_password_remote_data_source_contract.dart'
    as _i1028;
import '../../feature/forget_password/data/repositories/forget_password_repository_impl.dart'
    as _i876;
import '../../feature/forget_password/domain/repositories/forget_password_repository.dart'
    as _i170;
import '../../feature/forget_password/domain/use_cases/forget_password_use_case.dart'
    as _i774;
import '../../feature/forget_password/domain/use_cases/reset_password_use_case.dart'
    as _i33;
import '../../feature/forget_password/domain/use_cases/verify_reset_code_use_case.dart'
    as _i998;
import '../../feature/forget_password/presentation/cubit/forget_password_cubit.dart'
    as _i604;
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
    gh.factory<_i130.ForgetPasswordApiClient>(
      () => _i130.ForgetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i769.LoginApiClient>(
      () => _i769.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i103.SignUpApiClient>(
      () => _i103.SignUpApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i1028.ForgetPasswordRemoteDataSourceContract>(
      () => _i243.ForgetPasswordRemoteDataSourceImpl(
        apiClient: gh<_i130.ForgetPasswordApiClient>(),
        fss: gh<_i558.FlutterSecureStorage>(),
      ),
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
    gh.factory<_i170.ForgetPasswordRepository>(
      () => _i876.ForgetPasswordRepositoryImpl(
        remoteDataSource: gh<_i1028.ForgetPasswordRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i385.LoginRemoteDataSourceContract>(
      () => _i250.LoginRemoteDataSourceImpl(
        apiClient: gh<_i769.LoginApiClient>(),
      ),
    );
    gh.factory<_i774.SendOtpToEmailUseCase>(
      () => _i774.SendOtpToEmailUseCase(
        repository: gh<_i170.ForgetPasswordRepository>(),
      ),
    );
    gh.factory<_i716.SignupRemoteDataSourceContract>(
      () => _i1011.SignUpRemoteDataSourceImpl(
        homeApiClient: gh<_i103.SignUpApiClient>(),
      ),
    );
    gh.factory<_i374.LoginRepository>(
      () => _i197.LoginRepositoryImpl(
        remoteDataSource: gh<_i385.LoginRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i33.ResetPasswordUseCase>(
      () => _i33.ResetPasswordUseCase(gh<_i170.ForgetPasswordRepository>()),
    );
    gh.factory<_i998.VerifyOtpUseCase>(
      () => _i998.VerifyOtpUseCase(gh<_i170.ForgetPasswordRepository>()),
    );
    gh.factory<_i919.SignUpRepositoryContract>(
      () => _i337.SignUpRepositoryImpl(
        remoteDataSource: gh<_i716.SignupRemoteDataSourceContract>(),
        localDataSource: gh<_i623.SignupLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i46.LoginUseCase>(
      () => _i46.LoginUseCase(repository: gh<_i374.LoginRepository>()),
    );
    gh.factory<_i604.ForgetPasswordCubit>(
      () => _i604.ForgetPasswordCubit(
        sendOtpToEmailUseCase: gh<_i774.SendOtpToEmailUseCase>(),
        verifyOtpUseCase: gh<_i998.VerifyOtpUseCase>(),
        resetPasswordUseCase: gh<_i33.ResetPasswordUseCase>(),
      ),
    );
    gh.factory<_i280.SignUpUserUseCase>(
      () => _i280.SignUpUserUseCase(repo: gh<_i919.SignUpRepositoryContract>()),
    );
    gh.factory<_i453.LoginCubit>(
      () => _i453.LoginCubit(loginUseCase: gh<_i46.LoginUseCase>()),
    );
    gh.factory<_i906.SignUpCubit>(
      () => _i906.SignUpCubit(signUpUserUseCase: gh<_i280.SignUpUserUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}
