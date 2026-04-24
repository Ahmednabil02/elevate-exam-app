part of 'exams_cubit.dart';

class ExamsStates extends Equatable {
  final PaginationState<ExamEntity> examsState;

  const ExamsStates({this.examsState = const PaginationState.initial()});

  ExamsStates copyWith({
    PaginationState<ExamEntity>? examsState,
  }) {
    return ExamsStates(examsState: examsState ?? this.examsState);
  }

  @override
  List<Object?> get props => [examsState];
}
