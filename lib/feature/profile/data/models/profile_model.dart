import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/profile_entity.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends ProfileEntity {
  @JsonKey(name: '_id')
  final String? modelId;

  const ProfileModel({
    this.modelId,
    super.username,
    super.firstName,
    super.lastName,
    super.email,
    super.phone,
    super.role,
    super.image,
  }) : super(id: modelId);

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this)
    ..remove("_id")
    // ..remove("email")
    ..remove("image")
    ..remove("role");
  // ..remove("phone")
  // ..remove("username");
}

@JsonSerializable()
class ProfileModelResponse {
  @JsonKey(name: 'user')
  final ProfileModel? user;

  const ProfileModelResponse({this.user});

  factory ProfileModelResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelResponseToJson(this);
}
