import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/sign_up_post_entity.dart';

part 'sign_up_post_dto.g.dart';

@JsonSerializable()
class SignUpRequestDto {
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? rePassword;
  final String? phone;

  const SignUpRequestDto({
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.rePassword,
    this.phone,
  });

  factory SignUpRequestDto.fromEntity(SignUpPostEntity entity) {
    return SignUpRequestDto(
      username: entity.username,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      password: entity.password,
      rePassword: entity.rePassword,
      phone: entity.phone,
    );
  }

  factory SignUpRequestDto.fromJson(Map<String, dynamic> json) {
    return _$SignUpRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SignUpRequestDtoToJson(this);
}
