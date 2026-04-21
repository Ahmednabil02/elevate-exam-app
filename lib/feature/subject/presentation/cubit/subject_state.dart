part of 'subject_cubit.dart';

class SubjectStates extends Equatable {
  final BaseState<List<SubjectEntity>> subjectState;

  const SubjectStates({
    this.subjectState = const BaseState.initial(),
  });

  @override
  List<Object?> get props => [subjectState];

  SubjectStates copyWith({
    BaseState<List<SubjectEntity>>? subjectState,
  }) {
    return SubjectStates(
      subjectState: subjectState ?? this.subjectState,
    );
  }
}
