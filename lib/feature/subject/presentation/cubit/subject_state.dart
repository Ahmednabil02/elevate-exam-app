part of 'subject_cubit.dart';

class SubjectStates extends Equatable {
  final PaginationState<SubjectEntity> subjectState;

  const SubjectStates({this.subjectState = const PaginationState.initial()});

  SubjectStates copyWith({PaginationState<SubjectEntity>? subjectState}) {
    return SubjectStates(subjectState: subjectState ?? this.subjectState);
  }

  @override
  List<Object?> get props => [subjectState];
}
