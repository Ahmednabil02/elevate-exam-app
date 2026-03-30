import 'package:exam_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:exam_app/config/base_response/model/meta_dto.dart';
import 'package:exam_app/feature/exams/data/models/exam_dto.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exams_response_dto.g.dart';

@JsonSerializable()
class ExamsResponseDto {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'metadata')
  final MetaDto? metadata;

  @JsonKey(name: 'exams')
  final List<ExamDto>? exams;

  const ExamsResponseDto({this.message, this.metadata, this.exams});

  factory ExamsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ExamsResponseDtoFromJson(json);

  BasePaginationEntity<ExamEntity> toEntity() => BasePaginationEntity(
    meta: metadata?.toEntity() ?? (throw Exception('metadata is null')),
    data: exams?.map((e) => e.toEntity()).toList() ?? [],
  );
}
