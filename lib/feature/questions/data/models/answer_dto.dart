import 'package:equatable/equatable.dart';
import 'package:exam_app/feature/questions/domain/entities/answer_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answer_dto.g.dart';

@JsonSerializable()
class AnswerDto extends Equatable {
  @JsonKey(name: "answer")
  final String? answer;

  @JsonKey(name: "key")
  final String? key;

  const AnswerDto({this.answer, this.key});

  factory AnswerDto.fromJson(Map<String, dynamic> json) =>
      _$AnswerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerDtoToJson(this);

  @override
  List<Object?> get props => [answer, key];

  AnswerEntity toEntity() {
    return AnswerEntity(title: answer ?? "", key: key ?? "");
  }
}
