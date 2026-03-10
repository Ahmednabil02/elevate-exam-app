// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../core/network/network_info.dart' as _i892;
import '../network/api_consumer.dart' as _i931;
import '../network/api_module.dart' as _i50;
import '../network/app_interceptor.dart' as _i474;
import '../network/dio_consumer.dart' as _i802;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final apiModule = _$ApiModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => apiModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i161.InternetConnection>(
      () => apiModule.internetConnection,
    );
    gh.factory<_i474.AppInterceptor>(
      () => _i474.AppInterceptor(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i892.NetworkInfo>(
      () => _i892.NetworkInfoImpl(gh<_i161.InternetConnection>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => apiModule.getDio(gh<_i474.AppInterceptor>()),
    );
    gh.lazySingleton<_i931.ApiConsumer>(
      () => _i802.DioConsumer(client: gh<_i361.Dio>()),
    );
    return this;
  }
}

class _$ApiModule extends _i50.ApiModule {}
