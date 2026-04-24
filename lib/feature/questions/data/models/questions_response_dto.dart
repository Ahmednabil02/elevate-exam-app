import 'package:exam_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:exam_app/config/base_response/model/base_pagination_dto.dart';
import 'package:exam_app/config/base_response/model/meta_dto.dart';
import 'package:exam_app/feature/questions/data/models/question_dto.dart';
import 'package:exam_app/feature/questions/domain/entities/questions_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'questions_response_dto.g.dart';

@JsonSerializable()
class QuestionsResponseDto extends BasePaginationDto<QuestionDto> {
  @JsonKey(name: 'questions')
  final List<QuestionDto>? questions;
  final String? examId;
  final DateTime? startExamTime;

  const QuestionsResponseDto({
    super.message,
    super.metadata,
    this.questions,
    this.examId,
    this.startExamTime,
  }) : super(data: questions);

  factory QuestionsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionsResponseDtoFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(QuestionDto value) toJsonT) =>
      _$QuestionsResponseDtoToJson(this);

  Map<String, dynamic> saveLocal(Object? Function(QuestionDto value) toJsonT) =>
      _$QuestionsResponseDtoToJson(this);

  BasePaginationEntity<QuestionEntity> toQuestionEntity() =>
      toEntity<QuestionEntity>((dto) => dto.toEntity());

  QuestionsResponseDto copyWith({
    String? message,
    MetaDto? metadata,
    List<QuestionDto>? questions,
    String? examId,
    DateTime? startExamTime,
  }) {
    return QuestionsResponseDto(
      message: message ?? this.message,
      metadata: metadata ?? this.metadata,
      questions: questions ?? this.questions,
      examId: examId ?? this.examId,
      startExamTime: startExamTime ?? this.startExamTime,
    );
  }
}
