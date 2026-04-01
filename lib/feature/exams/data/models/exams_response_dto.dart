import 'package:exam_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:exam_app/config/base_response/model/base_pagination_dto.dart';
import 'package:exam_app/config/base_response/model/meta_dto.dart';
import 'package:exam_app/feature/exams/data/models/exam_dto.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exams_response_dto.g.dart';

@JsonSerializable()
class ExamsResponseDto extends BasePaginationDto<ExamDto> {
  @JsonKey(name: 'exams')
  final List<ExamDto>? exams;

  const ExamsResponseDto({
    super.message,
    super.metadata,
    this.exams,
  }) : super(data: exams);

  factory ExamsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ExamsResponseDtoFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(ExamDto value) toJsonT) =>
      _$ExamsResponseDtoToJson(this);

  BasePaginationEntity<ExamEntity> toExamEntity() =>
      toEntity<ExamEntity>((dto) => dto.toEntity());
}
