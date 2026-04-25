part of 'questions_cubit.dart';

class QuestionsState extends BaseState<List<QuestionEntity>> {
  final int currentPage;
  final ExamSessionEntity? examSession;
  final DateTime? examStartTime;
  final int? examDurationInMinutes;

  const QuestionsState({
    super.exception,
    super.data,
    super.state = BaseStateType.initial,
    required this.currentPage,
    this.examSession,
    this.examStartTime,
    this.examDurationInMinutes,
  });

  QuestionsState copyWith({
    BaseStateType? state,
    List<QuestionEntity>? data,
    Exception? exception,
    int? currentPage,
    bool? isDone,
    ExamSessionEntity? examSession,
    DateTime? examStartTime,
    int? examDurationInMinutes,
  }) {
    return QuestionsState(
      state: state ?? this.state,
      data: data ?? this.data,
      exception: exception ?? this.exception,
      currentPage: currentPage ?? this.currentPage,
      examSession: examSession ?? this.examSession,
      examStartTime: examStartTime ?? this.examStartTime,
      examDurationInMinutes:
          examDurationInMinutes ?? this.examDurationInMinutes,
    );
  }

  @override
  List<Object?> get props => [
    state,
    data,
    exception,
    currentPage,
    examSession,
    examStartTime,
    examDurationInMinutes,
  ];
}
