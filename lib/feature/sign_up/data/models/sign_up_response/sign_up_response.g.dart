// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResponse _$SignUpResponseFromJson(Map<String, dynamic> json) =>
    SignUpResponse(
      message: json['message'] as String?,
      token: json['token'] as String?,
      userDto: json['userDto'] == null
          ? null
          : UserDto.fromJson(json['userDto'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignUpResponseToJson(SignUpResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token,
      'userDto': instance.userDto,
    };
