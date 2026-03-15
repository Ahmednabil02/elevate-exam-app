
import 'package:exam_app/feature/sign_up/data/models/sign_up_post_model/sign_up_post_dto.dart';

class SignUpPostEntity {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String phone;

  SignUpPostEntity({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
  });

  SignUpPostDto toDto() {
    return SignUpPostDto(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
    );
  }
}
