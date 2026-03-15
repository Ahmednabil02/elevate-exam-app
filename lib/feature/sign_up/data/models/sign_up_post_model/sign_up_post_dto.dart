import 'package:json_annotation/json_annotation.dart';

part 'sign_up_post_dto.g.dart';

@JsonSerializable()
class SignUpPostDto {
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? rePassword;
  String? phone;

  SignUpPostDto({
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.rePassword,
    this.phone,
  });

  factory SignUpPostDto.fromJson(Map<String, dynamic> json) {
    return _$SignUpPostDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SignUpPostDtoToJson(this);
}
