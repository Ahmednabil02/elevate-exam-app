import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/sign_up/data/models/sign_up_post_model/sign_up_post_dto.dart';
import 'package:exam_app/feature/sign_up/data/models/sign_up_response/sign_up_response.dart';

abstract interface class SignupRemoteDataSourceContract {
  Future<Result<SignUpResponse>> signUpUser(SignUpRequestDto signupPostModel);
}
