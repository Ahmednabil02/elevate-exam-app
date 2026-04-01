part of 'exams_cubit.dart';

sealed class ExamsEvents {
  const ExamsEvents();
}

class GetExamsEvent extends ExamsEvents {
  final String? subjectId;
  const GetExamsEvent({required this.subjectId});
}

class LoadMoreExamsEvent extends ExamsEvents {
  final ExamParms params;
  const LoadMoreExamsEvent({required this.params});
}
