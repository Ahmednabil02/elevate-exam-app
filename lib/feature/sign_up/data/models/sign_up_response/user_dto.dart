import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? role;
  final bool? isVerified;
  @JsonKey(name: '_id')
  final String? id;
  final DateTime? createdAt;

  const UserDto({
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.id,
    this.createdAt,
  });

  @override
  String toString() {
    return 'User(username: $username, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, role: $role, isVerified: $isVerified, id: $id, createdAt: $createdAt)';
  }

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
