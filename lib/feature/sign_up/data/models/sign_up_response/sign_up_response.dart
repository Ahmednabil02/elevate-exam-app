import 'package:exam_app/feature/sign_up/domain/models/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'user_dto.dart';

part 'sign_up_response.g.dart';

@JsonSerializable()
class SignUpResponse {
  final String? message;
  final String? token;
  final UserDto? userDto;

  const SignUpResponse({this.message, this.token, this.userDto});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return _$SignUpResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);

  UserEntity toUserEntity() {
    return UserEntity(
      id: userDto?.id ?? "",
      username: userDto?.username ?? "",
      firstName: userDto?.firstName ?? "",
      lastName: userDto?.lastName ?? "",
      email: userDto?.email ?? "",
      phone: userDto?.phone ?? "",
      role: userDto?.role ?? "",
      token: token ?? "",
    );
  }
}
