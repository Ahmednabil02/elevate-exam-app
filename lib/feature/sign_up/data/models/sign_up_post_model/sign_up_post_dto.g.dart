// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_post_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpPostDto _$SignUpPostDtoFromJson(Map<String, dynamic> json) =>
    SignUpPostDto(
      username: json['username'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      rePassword: json['rePassword'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$SignUpPostDtoToJson(SignUpPostDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'rePassword': instance.rePassword,
      'phone': instance.phone,
    };
