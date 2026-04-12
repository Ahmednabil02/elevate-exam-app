import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/sign_up/domain/models/sign_up_post_entity.dart';
import 'package:exam_app/feature/sign_up/domain/models/user_entity.dart';

abstract interface class SignUpRepositoryContract {
  Future<Result<UserEntity>> signUpUser(SignUpPostEntity signupPostModel);
}
