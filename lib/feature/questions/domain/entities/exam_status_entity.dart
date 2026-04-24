import 'package:equatable/equatable.dart';

/// Represents the status of an exam
class ExamStatusEntity extends Equatable {
  /// Whether the exam has been started before
  final bool hasStarted;

  /// Whether the exam time has expired
  final bool hasExpired;

  /// Whether the exam has been completed (all questions answered)
  final bool isCompleted;

  /// The start time of the exam (null if not started)
  final DateTime? startTime;

  /// The remaining time in minutes (null if not started or expired)
  final int? remainingMinutes;

  /// The exam duration in minutes
  final int examDurationMinutes;

  /// Whether the user can continue the exam
  bool get canContinue => hasStarted && !hasExpired && !isCompleted;

  /// Whether the exam should be cleared (expired or completed)
  bool get shouldClear => hasExpired || isCompleted;

  /// Whether this is a fresh start
  bool get isFreshStart => !hasStarted;

  const ExamStatusEntity({
    required this.hasStarted,
    required this.hasExpired,
    required this.isCompleted,
    required this.examDurationMinutes,
    this.startTime,
    this.remainingMinutes,
  });

  @override
  List<Object?> get props => [
    hasStarted,
    hasExpired,
    isCompleted,
    startTime,
    remainingMinutes,
    examDurationMinutes,
  ];

  ExamStatusEntity copyWith({
    bool? hasStarted,
    bool? hasExpired,
    bool? isCompleted,
    DateTime? startTime,
    int? remainingMinutes,
    int? examDurationMinutes,
  }) {
    return ExamStatusEntity(
      hasStarted: hasStarted ?? this.hasStarted,
      hasExpired: hasExpired ?? this.hasExpired,
      isCompleted: isCompleted ?? this.isCompleted,
      startTime: startTime ?? this.startTime,
      remainingMinutes: remainingMinutes ?? this.remainingMinutes,
      examDurationMinutes: examDurationMinutes ?? this.examDurationMinutes,
    );
  }
}
