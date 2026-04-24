import 'package:json_annotation/json_annotation.dart';
import '../../domain/models/subject_entity.dart';

part 'subject_model.g.dart';

@JsonSerializable()
class SubjectModel {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "icon")
  final String? icon;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  SubjectModel({
    this.id,
    this.name,
    this.icon,
    this.createdAt,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectModelToJson(this);

  SubjectEntity toEntity() {
    return SubjectEntity(
      id: id,
      name: name,
      icon: icon,
      createdAt: createdAt,
    );
  }
}

@JsonSerializable()
class SubjectsResponseModel {
  final String? message;
  final List<SubjectModel>? subjects;

  SubjectsResponseModel({this.message, this.subjects});

  factory SubjectsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectsResponseModelToJson(this);
}
