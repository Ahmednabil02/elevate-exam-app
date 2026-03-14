import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/config/uses_cases/pagination_params.dart';

import 'pagination_state.dart';

mixin StateTransitions<T> {
  BaseState<T> toLoading() => const BaseState.loading();

  BaseState<T> toSuccess(T data) => BaseState.success(data);

  BaseState<T> toError(Exception e) => BaseState.error(e);

  BaseState<T> toInitial() => const BaseState.initial();
}

mixin PaginationTransitions<T> {
  PaginationState<T> toLoading({PaginationParams? query});

  PaginationState<T> toLoadingMore();

  PaginationState<T> toSuccess(List<T> data, {bool? hasMore});

  PaginationState<T> toError(Exception e);

  PaginationState<T> toErrorMore(Exception e);

  PaginationState<T> toInitial() => PaginationState.initial();
}
