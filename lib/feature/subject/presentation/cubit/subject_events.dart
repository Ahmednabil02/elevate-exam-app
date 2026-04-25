part of 'subject_cubit.dart';

sealed class SubjectEvents {
  const SubjectEvents();
}

class GetSubjectsEvent extends SubjectEvents {
  final String? search;
  const GetSubjectsEvent({this.search});
}

class LoadMoreSubjectsEvent extends SubjectEvents {
  final SubjectParm params;
  const LoadMoreSubjectsEvent({required this.params});
}
