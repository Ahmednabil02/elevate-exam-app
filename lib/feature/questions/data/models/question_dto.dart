import 'package:equatable/equatable.dart';
import 'package:exam_app/feature/exams/data/models/exam_dto.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/questions/domain/entities/questions_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'answer_dto.dart';

part 'question_dto.g.dart';

@JsonSerializable()
class QuestionDto extends Equatable {
  @JsonKey(name: "answers")
  final List<AnswerDto>? answers;

  @JsonKey(name: "type")
  final String? type;

  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "question")
  final String? question;

  @JsonKey(name: "correct")
  final String? correct;

  @JsonKey(name: "exam")
  final ExamDto? exam;
  final String? submitAnswer;

  const QuestionDto({
    this.answers,
    this.type,
    this.id,
    this.question,
    this.correct,
    this.submitAnswer,
    this.exam,
  });

  factory QuestionDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionDtoToJson(this);

  @override
  List<Object?> get props => [id, question, type, correct, answers, exam];

  QuestionEntity toEntity() {
    return QuestionEntity(
      questionTitle: question ?? "",
      id: id ?? "",
      correctAnswer: correct ?? "",
      type: type ?? "",
      answeredQuestion: submitAnswer,
      answers: answers?.map((a) => a.toEntity()).toList() ?? [],
      exam: exam?.toEntity() ?? ExamEntity(id: "", title: "", subject: ""),
    );
  }
}
