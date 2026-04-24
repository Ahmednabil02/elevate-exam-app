import 'package:equatable/equatable.dart';
import 'package:exam_app/feature/questions/domain/entities/questions_entity.dart';

class ExamSessionEntity extends Equatable {
  final String examId;
  final DateTime startTime;
  final int durationInMinutes;
  final List<QuestionEntity> questions;
  final ExamSessionStatus status;

  const ExamSessionEntity({
    required this.examId,
    required this.startTime,
    required this.durationInMinutes,
    required this.questions,
    required this.status,
  });

  int get remainingMinutes {
    final now = DateTime.now();
    final endTime = startTime.add(Duration(minutes: durationInMinutes));
    final remaining = endTime.difference(now).inMinutes;
    return remaining > 0 ? remaining : 0;
  }

  bool get isExpired {
    final now = DateTime.now();
    final endTime = startTime.add(Duration(minutes: durationInMinutes));
    return now.isAfter(endTime);
  }

  DateTime get endTime {
    return startTime.add(Duration(minutes: durationInMinutes));
  }

  ExamSessionEntity copyWith({
    String? examId,
    DateTime? startTime,
    int? durationInMinutes,
    List<QuestionEntity>? questions,
    ExamSessionStatus? status,
  }) {
    return ExamSessionEntity(
      examId: examId ?? this.examId,
      startTime: startTime ?? this.startTime,
      durationInMinutes: durationInMinutes ?? this.durationInMinutes,
      questions: questions ?? this.questions,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    examId,
    startTime,
    durationInMinutes,
    questions,
    status,
  ];
}

enum ExamSessionStatus { notStarted, inProgress, expired, completed }
