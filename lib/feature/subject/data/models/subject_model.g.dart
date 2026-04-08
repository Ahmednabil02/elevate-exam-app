// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectModel _$SubjectModelFromJson(Map<String, dynamic> json) => SubjectModel(
  id: json['_id'] as String?,
  name: json['name'] as String?,
  icon: json['icon'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$SubjectModelToJson(SubjectModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'createdAt': instance.createdAt,
    };

SubjectsResponseModel _$SubjectsResponseModelFromJson(
  Map<String, dynamic> json,
) => SubjectsResponseModel(
  message: json['message'] as String?,
  subjects: (json['subjects'] as List<dynamic>?)
      ?.map((e) => SubjectModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SubjectsResponseModelToJson(
  SubjectsResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'subjects': instance.subjects,
};
