part of 'answers_cubit.dart';

class AnswersState extends BaseState<List<QuestionEntity>> {
  final ExamResultEntity? result;

  const AnswersState({
    super.exception,
    super.data,
    super.state = BaseStateType.initial,
    this.result,
  });

  List<QuestionEntity> get questions => data ?? [];

  AnswersState copyWith({
    BaseStateType? state,
    List<QuestionEntity>? questions,
    Exception? exception,
    ExamResultEntity? result,
  }) {
    return AnswersState(
      state: state ?? super.state,
      data: questions ?? data,
      exception: exception ?? super.exception,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [state, data, exception, result];
}
