import 'package:exam_app/config/uses_cases/filter_param.dart';
import 'package:exam_app/config/uses_cases/pagination_params.dart';

class ExamParms extends PaginationParams {
  final String subjectId;

  const ExamParms({required this.subjectId, super.page, super.limit});

  @override
  List<FilterParam> get filterList => [
    FilterParam(key: 'subject', value: subjectId),
  ];

  @override
  ExamParms copyWith({
    String? subjectId,
    int? page,
    int? limit,
  }) {
    return ExamParms(
      subjectId: subjectId ?? this.subjectId,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }

  @override
  List<Object?> get props => [...super.props, subjectId];
}
