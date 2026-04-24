import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/sign_up/data/data_sources/sign_up_local_data_source.dart';
import 'package:exam_app/feature/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:exam_app/feature/sign_up/data/models/sign_up_post_model/sign_up_post_dto.dart';
import 'package:exam_app/feature/sign_up/data/models/sign_up_response/sign_up_response.dart';
import 'package:exam_app/feature/sign_up/domain/models/sign_up_post_entity.dart';
import 'package:exam_app/feature/sign_up/domain/models/user_entity.dart';
import 'package:exam_app/feature/sign_up/domain/repositories/sign_up_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SignUpRepositoryContract)
class SignUpRepositoryImpl implements SignUpRepositoryContract {
  final SignupRemoteDataSourceContract remoteDataSource;
  final SignupLocalDataSourceContract localDataSource;

  const SignUpRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<UserEntity>> signUpUser(
    SignUpPostEntity signupPostModel,
  ) async {
    final dto = SignUpRequestDto.fromEntity(signupPostModel);
    final response = await remoteDataSource.signUpUser(dto);
    switch (response) {
      case Success<SignUpResponse>():
        await localDataSource.saveUserToken(response.data?.token ?? "");
        return Success<UserEntity>(data: response.data?.toUserEntity());
      case Error<SignUpResponse>():
        return Error<UserEntity>(exception: response.exception);
    }
  }
}
