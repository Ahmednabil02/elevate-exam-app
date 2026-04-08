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

import '../../feature/subject/api/subject_api_service.dart' as _i389;
import '../../feature/subject/data/data_sources/subject_remote_data_source.dart'
    as _i206;
import '../../feature/subject/data/repositories/subject_repository_impl.dart'
    as _i41;
import '../../feature/subject/domain/repositories/subject_repository_contract.dart'
    as _i1022;
import '../../feature/subject/domain/usecases/get_subjects_use_case.dart'
    as _i32;
import '../../feature/subject/presentation/cubit/subject_cubit.dart' as _i741;
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
    gh.factory<_i389.SubjectApiService>(
      () => _i389.SubjectApiService(gh<_i361.Dio>()),
    );
    gh.singleton<_i449.AppInterceptors>(
      () => _i449.AppInterceptors(
        dio: gh<_i361.Dio>(),
        fss: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i206.SubjectRemoteDataSource>(
      () => _i206.SubjectRemoteDataSourceImpl(gh<_i389.SubjectApiService>()),
    );
    gh.factory<_i1022.SubjectRepositoryContract>(
      () => _i41.SubjectRepositoryImpl(gh<_i206.SubjectRemoteDataSource>()),
    );
    gh.factory<_i32.GetSubjectsUseCase>(
      () => _i32.GetSubjectsUseCase(gh<_i1022.SubjectRepositoryContract>()),
    );
    gh.factory<_i741.SubjectCubit>(
      () => _i741.SubjectCubit(gh<_i32.GetSubjectsUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}
