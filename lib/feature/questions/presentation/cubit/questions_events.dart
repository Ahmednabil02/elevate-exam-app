sealed class QuestionsEvent {}

class AnswerSelectedEvent extends QuestionsEvent {
  final String selectAnswer;
  final int index;

  AnswerSelectedEvent({required this.index, required this.selectAnswer});
}

class QuestionChanged extends QuestionsEvent {
  final int currentPage;

  QuestionChanged({required this.currentPage});
}

class GetQuestionsEvent extends QuestionsEvent {
  final String examId;
  final int examDurationInMinutes;

  GetQuestionsEvent({
    required this.examId,
    required this.examDurationInMinutes,
  });
}

class CheckExamSessionEvent extends QuestionsEvent {
  final String examId;
  final int examDurationInMinutes;

  CheckExamSessionEvent({
    required this.examId,
    required this.examDurationInMinutes,
  });
}

class ResumeExamEvent extends QuestionsEvent {
  final String examId;

  ResumeExamEvent({required this.examId});
}

class ClearExpiredExamEvent extends QuestionsEvent {
  final String examId;

  ClearExpiredExamEvent({required this.examId});
}

