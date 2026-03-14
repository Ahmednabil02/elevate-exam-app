import 'package:equatable/equatable.dart';
import 'package:exam_app/config/uses_cases/pagination_params.dart';

import 'state_handlers.dart';
import 'state_mixins.dart';
import 'state_types.dart';

class PaginationState<T> extends Equatable
    with PaginationTransitions<T>
    implements PaginationStateHandler<T> {
  final PaginationStateType state;
  final List<T> data;
  final Exception? exception;
  final bool hasMore;
  final PaginationParams query;

  const PaginationState({
    required this.state,
    required this.data,
    this.exception,
    this.hasMore = true,
    required this.query,
  });

  @override
  List<Object?> get props => [state, data, exception, hasMore, query];

  const PaginationState.initial()
    : state = PaginationStateType.initial,
      data = const [],
      exception = null,
      hasMore = true,
      query = const PaginationParams();

  bool get isInitial => state == PaginationStateType.initial;

  bool get isLoading => state == PaginationStateType.loading;

  bool get isLoadingMore => state == PaginationStateType.loadingMore;

  bool get isSuccess => state == PaginationStateType.success;

  bool get isError => state == PaginationStateType.error;

  bool get isErrorMore => state == PaginationStateType.errorMore;

  bool get isEmpty => data.isEmpty;

  bool get isNotEmpty => data.isNotEmpty;

  int get itemCount => data.length;

  bool get canLoadMore => hasMore && isNotEmpty;

  @override
  PaginationState<T> toLoading({PaginationParams? query}) => PaginationState(
    state: PaginationStateType.loading,
    data: const [],
    hasMore: true,
    query: query ?? this.query.copyWith(page: 1),
  );

  @override
  PaginationState<T> toLoadingMore() => PaginationState(
    state: PaginationStateType.loadingMore,
    data: data,
    hasMore: hasMore,
    query: query.copyWith(page: (query.page ?? 1) + 1),
  );

  @override
  PaginationState<T> toSuccess(List<T> newData, {bool? hasMore}) =>
      PaginationState(
        state: PaginationStateType.success,
        data: query.page == 1 ? newData : [...data, ...newData],
        hasMore: hasMore ?? newData.isNotEmpty,
        query: query,
      );

  @override
  PaginationState<T> toError(Exception e) => PaginationState(
    state: PaginationStateType.error,
    data: const [],
    exception: e,
    hasMore: false,
    query: query.copyWith(page: 1),
  );

  @override
  PaginationState<T> toErrorMore(Exception e) => PaginationState(
    state: PaginationStateType.errorMore,
    data: data,
    exception: e,
    hasMore: hasMore,
    query: query,
  );

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(List<T> data) loadingMore,
    required R Function(List<T> data, bool hasMore) success,
    required R Function(Exception exception) error,
    required R Function(List<T> data, Exception exception) errorMore,
  }) {
    return switch (state) {
      PaginationStateType.initial => initial(),
      PaginationStateType.loading => loading(),
      PaginationStateType.loadingMore => loadingMore(data),
      PaginationStateType.success => success(data, hasMore),
      PaginationStateType.error => error(exception!),
      PaginationStateType.errorMore => errorMore(data, exception!),
    };
  }

  @override
  String toString() =>
      'PaginationState($state, items: $itemCount, hasMore: $hasMore, page: ${query.page}${exception != null ? ', error: $exception' : ''})';
}
