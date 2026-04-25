import 'package:exam_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:exam_app/config/base_response/model/base_pagination_dto.dart';
import 'package:exam_app/config/base_response/model/meta_dto.dart';
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

  SubjectModel({this.id, this.name, this.icon, this.createdAt});

  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectModelToJson(this);

  SubjectEntity toEntity() {
    return SubjectEntity(id: id, name: name, icon: icon, createdAt: createdAt);
  }
}

@JsonSerializable()
class SubjectsResponseModel extends BasePaginationDto<SubjectModel> {
  @JsonKey(name: 'subjects')
  final List<SubjectModel>? subjects;

  const SubjectsResponseModel({super.message, super.metadata, this.subjects})
    : super(data: subjects);

  factory SubjectsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectsResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(SubjectModel value) toJsonT) =>
      _$SubjectsResponseModelToJson(this);

  BasePaginationEntity<SubjectEntity> toSubjectEntity() =>
      toEntity<SubjectEntity>((dto) => dto.toEntity());
}
