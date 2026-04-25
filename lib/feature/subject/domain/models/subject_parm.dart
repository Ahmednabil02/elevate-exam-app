import 'package:exam_app/config/uses_cases/filter_param.dart';
import 'package:exam_app/config/uses_cases/pagination_params.dart';

class SubjectParm extends PaginationParams {
  final String? search;

  const SubjectParm({this.search, super.page, super.limit});

  @override
  List<FilterParam> get filterList => [
    FilterParam(key: 'search', value: search),
  ];

  @override
  SubjectParm copyWith({String? search, int? page, int? limit}) {
    return SubjectParm(
      search: search ?? this.search,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }

  @override
  List<Object?> get props => [...super.props, search];
}
