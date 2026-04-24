import 'package:equatable/equatable.dart';

class ExamResultEntity extends Equatable {
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;
  final int unansweredQuestions;
  final int scorePercentage;

  const ExamResultEntity({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.unansweredQuestions,
    required this.scorePercentage,
  });

  int get answeredQuestions => correctAnswers + incorrectAnswers;

  bool get isPassed => scorePercentage >= 50;

  @override
  List<Object?> get props => [
    totalQuestions,
    correctAnswers,
    incorrectAnswers,
    unansweredQuestions,
    scorePercentage,
  ];
}
