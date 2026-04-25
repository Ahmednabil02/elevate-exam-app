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

import '../../core/api/datasources/auth_local_data_source_impl.dart' as _i424;
import '../../core/data/datasources/auth_local_data_source.dart' as _i836;
import '../../feature/answers/presentation/cubit/answers_cubit.dart' as _i351;
import '../../feature/exams/api/api_client/exams_api_client.dart' as _i503;
import '../../feature/exams/api/data%D9%80sources/exams_remote_data_source_impl.dart'
    as _i79;
import '../../feature/exams/data/data%D9%80sources/exams_remote_data_source_contract.dart'
    as _i1045;
import '../../feature/exams/data/repositories/exams_repository_impl.dart'
    as _i616;
import '../../feature/exams/domain/repositories/exams_repository.dart'
    as _i1052;
import '../../feature/exams/domain/use_cases/get_exams_by_subject_use_case.dart'
    as _i441;
import '../../feature/exams/presentation/cubit/exams_cubit.dart' as _i982;
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
import '../../feature/profile/data/api/profile_api_service.dart' as _i1058;
import '../../feature/profile/data/repositories/profile_repository_impl.dart'
    as _i1035;
import '../../feature/profile/domain/repositories/profile_repository.dart'
    as _i173;
import '../../feature/profile/domain/use_cases/change_password_use_case.dart'
    as _i240;
import '../../feature/profile/domain/use_cases/get_profile_use_case.dart'
    as _i152;
import '../../feature/profile/domain/use_cases/update_profile_use_case.dart'
    as _i639;
import '../../feature/profile/presentation/cubit/profile_cubit.dart' as _i499;
import '../../feature/questions/api/api_client/questions_api_client.dart'
    as _i412;
import '../../feature/questions/api/data_sources/questions_local_data_source_impl.dart'
    as _i681;
import '../../feature/questions/api/data_sources/questions_remote_data_source_impl.dart'
    as _i982;
import '../../feature/questions/data/data%D9%80sources/questions_local_data_source_contract.dart'
    as _i253;
import '../../feature/questions/data/data%D9%80sources/questions_remote_data_source_contract.dart'
    as _i190;
import '../../feature/questions/data/repositories/questions_repository_impl.dart'
    as _i181;
import '../../feature/questions/domain/repositories/questions_repository.dart'
    as _i566;
import '../../feature/questions/domain/use_cases/check_exam_session_use_case.dart'
    as _i1046;
import '../../feature/questions/domain/use_cases/clear_exam_session_use_case.dart'
    as _i314;
import '../../feature/questions/domain/use_cases/get_questions_use_case.dart'
    as _i1061;
import '../../feature/questions/domain/use_cases/get_saved_questions_use_case.dart'
    as _i350;
import '../../feature/questions/domain/use_cases/resume_exam_use_case.dart'
    as _i619;
import '../../feature/questions/domain/use_cases/save_answer_use_case.dart'
    as _i493;
import '../../feature/questions/domain/use_cases/save_exam_end_time_use_case.dart'
    as _i1045;
import '../../feature/questions/presentation/cubit/questions_cubit.dart'
    as _i816;
import '../../feature/sign_up/api/api_client/sign_up_api_client.dart' as _i103;
import '../../feature/sign_up/api/data_sources/sign_up_local_data_source_impl.dart'
    as _i973;
import '../../feature/sign_up/api/data_sources/sign_up_remote_data_source_impl.dart'
    as _i1025;
import '../../feature/sign_up/data/data_sources/sign_up_local_data_source.dart'
    as _i550;
import '../../feature/sign_up/data/data_sources/sign_up_remote_data_source.dart'
    as _i762;
import '../../feature/sign_up/data/repositories/sign_up_repository_impl.dart'
    as _i337;
import '../../feature/sign_up/domain/repositories/sign_up_repository_contract.dart'
    as _i919;
import '../../feature/sign_up/domain/use_cases/sign_up_user_use_case.dart'
    as _i682;
import '../../feature/sign_up/presentation/cubit/sign_up_cubit.dart' as _i906;
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
import '../database/database_module.dart' as _i215;
import '../database/exam_database.dart' as _i387;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    final databaseModule = _$DatabaseModule();
    gh.singleton<_i361.Dio>(() => dioModule.dio());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => dioModule.secureStorage(),
    );
    gh.lazySingleton<_i361.CancelToken>(() => dioModule.cancelToken());
    gh.lazySingleton<_i161.InternetConnection>(
      () => dioModule.internetConnection(),
    );
    gh.lazySingleton<_i387.ExamDatabase>(() => databaseModule.database);
    gh.lazySingleton<_i503.ExamsApiClient>(
      () => _i503.ExamsApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i130.ForgetPasswordApiClient>(
      () => _i130.ForgetPasswordApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i412.QuestionsApiClient>(
      () => _i412.QuestionsApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i103.SignUpApiClient>(
      () => _i103.SignUpApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i769.LoginApiClient>(
      () => _i769.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i1058.ProfileApiService>(
      () => _i1058.ProfileApiService(gh<_i361.Dio>()),
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
    gh.lazySingleton<_i253.QuestionsLocalDataSourceContract>(
      () => _i681.QuestionsLocalDataSourceImpl(gh<_i387.ExamDatabase>()),
    );
    gh.factory<_i1028.ForgetPasswordRemoteDataSourceContract>(
      () => _i243.ForgetPasswordRemoteDataSourceImpl(
        apiClient: gh<_i130.ForgetPasswordApiClient>(),
      ),
    );
    gh.lazySingleton<_i836.AuthLocalDataSourceContract>(
      () =>
          _i424.AuthLocalDataSourceImpl(fss: gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i170.ForgetPasswordRepository>(
      () => _i876.ForgetPasswordRepositoryImpl(
        remoteDataSource: gh<_i1028.ForgetPasswordRemoteDataSourceContract>(),
        localDataSource: gh<_i836.AuthLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i1045.ExamsRemoteDataSourceContract>(
      () =>
          _i79.ExamsRemoteDataSourceImpl(apiClient: gh<_i503.ExamsApiClient>()),
    );
    gh.lazySingleton<_i550.SignupLocalDataSourceContract>(
      () => _i973.SignupLocalDataSourceImpl(
        fss: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i173.ProfileRepository>(
      () => _i1035.ProfileRepositoryImpl(
        gh<_i1058.ProfileApiService>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.lazySingleton<_i762.SignupRemoteDataSourceContract>(
      () => _i1025.SignUpRemoteDataSourceImpl(
        homeApiClient: gh<_i103.SignUpApiClient>(),
      ),
    );
    gh.factory<_i33.ResetPasswordUseCase>(
      () => _i33.ResetPasswordUseCase(gh<_i170.ForgetPasswordRepository>()),
    );
    gh.factory<_i998.VerifyOtpUseCase>(
      () => _i998.VerifyOtpUseCase(gh<_i170.ForgetPasswordRepository>()),
    );
    gh.factory<_i206.SubjectRemoteDataSource>(
      () => _i206.SubjectRemoteDataSourceImpl(gh<_i389.SubjectApiService>()),
    );
    gh.factory<_i1022.SubjectRepositoryContract>(
      () => _i41.SubjectRepositoryImpl(gh<_i206.SubjectRemoteDataSource>()),
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
    gh.lazySingleton<_i190.QuestionsRemoteDataSourceContract>(
      () => _i982.QuestionsRemoteDataSourceImpl(
        apiClient: gh<_i412.QuestionsApiClient>(),
      ),
    );
    gh.lazySingleton<_i919.SignUpRepositoryContract>(
      () => _i337.SignUpRepositoryImpl(
        remoteDataSource: gh<_i762.SignupRemoteDataSourceContract>(),
        localDataSource: gh<_i550.SignupLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i240.ChangePasswordUseCase>(
      () => _i240.ChangePasswordUseCase(gh<_i173.ProfileRepository>()),
    );
    gh.factory<_i152.GetProfileUseCase>(
      () => _i152.GetProfileUseCase(gh<_i173.ProfileRepository>()),
    );
    gh.factory<_i639.UpdateProfileUseCase>(
      () => _i639.UpdateProfileUseCase(gh<_i173.ProfileRepository>()),
    );
    gh.factory<_i566.QuestionsRepositoryContract>(
      () => _i181.QuestionsRepositoryImpl(
        questionsRemoteDataSourceContract:
            gh<_i190.QuestionsRemoteDataSourceContract>(),
        questionsLocalDataSourceContract:
            gh<_i253.QuestionsLocalDataSourceContract>(),
      ),
    );
    gh.factory<_i32.GetSubjectsUseCase>(
      () => _i32.GetSubjectsUseCase(gh<_i1022.SubjectRepositoryContract>()),
    );
    gh.factory<_i741.SubjectCubit>(
      () =>
          _i741.SubjectCubit(getSubjectsUseCase: gh<_i32.GetSubjectsUseCase>()),
    );
    gh.factory<_i374.LoginRepository>(
      () => _i197.LoginRepositoryImpl(
        remoteDataSource: gh<_i385.LoginRemoteDataSourceContract>(),
      ),
    );
    gh.factory<_i604.ForgetPasswordCubit>(
      () => _i604.ForgetPasswordCubit(
        sendOtpToEmailUseCase: gh<_i774.SendOtpToEmailUseCase>(),
        verifyOtpUseCase: gh<_i998.VerifyOtpUseCase>(),
        resetPasswordUseCase: gh<_i33.ResetPasswordUseCase>(),
      ),
    );
    gh.factory<_i1052.ExamsRepository>(
      () => _i616.ExamsRepositoryImpl(
        examsRemoteDataSourceContract:
            gh<_i1045.ExamsRemoteDataSourceContract>(),
      ),
    );
    gh.lazySingleton<_i682.SignUpUserUseCase>(
      () => _i682.SignUpUserUseCase(repo: gh<_i919.SignUpRepositoryContract>()),
    );
    gh.factory<_i441.GetExamsBySubjectUseCase>(
      () => _i441.GetExamsBySubjectUseCase(gh<_i1052.ExamsRepository>()),
    );
    gh.factory<_i1061.GetQuestionsUseCase>(
      () => _i1061.GetQuestionsUseCase(
        repo: gh<_i566.QuestionsRepositoryContract>(),
      ),
    );
    gh.factory<_i906.SignUpCubit>(
      () => _i906.SignUpCubit(signUpUserUseCase: gh<_i682.SignUpUserUseCase>()),
    );
    gh.factory<_i499.ProfileCubit>(
      () => _i499.ProfileCubit(
        gh<_i152.GetProfileUseCase>(),
        gh<_i639.UpdateProfileUseCase>(),
        gh<_i240.ChangePasswordUseCase>(),
      ),
    );
    gh.factory<_i46.LoginUseCase>(
      () => _i46.LoginUseCase(repository: gh<_i374.LoginRepository>()),
    );
    gh.factory<_i982.ExamsCubit>(
      () => _i982.ExamsCubit(
        getExamsBySubjectUseCase: gh<_i441.GetExamsBySubjectUseCase>(),
      ),
    );
    gh.factory<_i1046.CheckExamSessionUseCase>(
      () => _i1046.CheckExamSessionUseCase(
        repository: gh<_i566.QuestionsRepositoryContract>(),
      ),
    );
    gh.factory<_i314.ClearExamSessionUseCase>(
      () => _i314.ClearExamSessionUseCase(
        repository: gh<_i566.QuestionsRepositoryContract>(),
      ),
    );
    gh.factory<_i350.GetSavedQuestionsUseCase>(
      () => _i350.GetSavedQuestionsUseCase(
        repository: gh<_i566.QuestionsRepositoryContract>(),
      ),
    );
    gh.factory<_i619.ResumeExamUseCase>(
      () => _i619.ResumeExamUseCase(
        repository: gh<_i566.QuestionsRepositoryContract>(),
      ),
    );
    gh.factory<_i493.SaveAnswerUseCase>(
      () => _i493.SaveAnswerUseCase(
        repository: gh<_i566.QuestionsRepositoryContract>(),
      ),
    );
    gh.factory<_i1045.SaveExamEndTimeUseCase>(
      () => _i1045.SaveExamEndTimeUseCase(
        repository: gh<_i566.QuestionsRepositoryContract>(),
      ),
    );
    gh.factory<_i351.AnswersCubit>(
      () => _i351.AnswersCubit(
        getSavedQuestionsUseCase: gh<_i350.GetSavedQuestionsUseCase>(),
      ),
    );
    gh.factory<_i816.QuestionsCubit>(
      () => _i816.QuestionsCubit(
        questionsUseCase: gh<_i1061.GetQuestionsUseCase>(),
        checkExamSessionUseCase: gh<_i1046.CheckExamSessionUseCase>(),
        resumeExamUseCase: gh<_i350.GetSavedQuestionsUseCase>(),
        clearExamSessionUseCase: gh<_i314.ClearExamSessionUseCase>(),
        saveAnswerUseCase: gh<_i493.SaveAnswerUseCase>(),
        saveExamEndTimeUseCase: gh<_i1045.SaveExamEndTimeUseCase>(),
      ),
    );
    gh.factory<_i453.LoginCubit>(
      () => _i453.LoginCubit(loginUseCase: gh<_i46.LoginUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}

class _$DatabaseModule extends _i215.DatabaseModule {}
