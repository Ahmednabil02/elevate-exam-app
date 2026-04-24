sealed class AnswersEvent {}

class LoadAnswersEvent extends AnswersEvent {
  final String examId;

  LoadAnswersEvent({required this.examId});
}
