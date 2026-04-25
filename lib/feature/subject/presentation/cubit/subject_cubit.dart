import 'package:equatable/equatable.dart';
import 'package:exam_app/config/base_state/pagination_state.dart';
import 'package:exam_app/feature/subject/domain/models/subject_entity.dart';
import 'package:exam_app/feature/subject/domain/models/subject_parm.dart';
import 'package:exam_app/feature/subject/domain/usecases/get_subjects_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'subject_events.dart';

part 'subject_state.dart';

@injectable
class SubjectCubit extends Cubit<SubjectStates> {
  final GetSubjectsUseCase _getSubjectsUseCase;

  SubjectCubit({required GetSubjectsUseCase getSubjectsUseCase})
    : _getSubjectsUseCase = getSubjectsUseCase,
      super(const SubjectStates());

  @override
  void emit(SubjectStates state) {
    if (!isClosed) super.emit(state);
  }

  Future<void> doIntent(SubjectEvents event) async => switch (event) {
    GetSubjectsEvent() => _getSubjects(event),
    LoadMoreSubjectsEvent() => _loadMore(event),
  };

  Future<void> _getSubjects(GetSubjectsEvent event) async {
    if (state.subjectState.isLoading) return;
    final params = SubjectParm(page: 1, search: event.search);
    emit(
      state.copyWith(subjectState: state.subjectState.toLoading(query: params)),
    );

    final result = await _getSubjectsUseCase.call(params);

    result.when(
      success: (data) {
        if (data != null) {
          emit(
            state.copyWith(
              subjectState: state.subjectState.toSuccessFromEntity(data),
            ),
          );
        } else {
          emit(
            state.copyWith(
              subjectState: state.subjectState.toError(
                Exception('No data received'),
              ),
            ),
          );
        }
      },
      error: (exception) {
        emit(
          state.copyWith(
            subjectState: state.subjectState.toError(
              exception ?? Exception('Unknown error'),
            ),
          ),
        );
      },
    );
  }

  Future<void> _loadMore(LoadMoreSubjectsEvent event) async {
    if (!state.subjectState.canLoadMore) return;

    emit(state.copyWith(subjectState: state.subjectState.toLoadingMore()));

    final result = await _getSubjectsUseCase.call(event.params);

    result.when(
      success: (data) {
        if (data != null) {
          emit(
            state.copyWith(
              subjectState: state.subjectState.toSuccessFromEntity(data),
            ),
          );
        } else {
          emit(
            state.copyWith(
              subjectState: state.subjectState.toErrorMore(
                Exception('No data received'),
              ),
            ),
          );
        }
      },
      error: (exception) {
        emit(
          state.copyWith(
            subjectState: state.subjectState.toErrorMore(
              exception ?? Exception('Unknown error'),
            ),
          ),
        );
      },
    );
  }

  Future<void> refreshSubjects({String? search}) async {
    await doIntent(GetSubjectsEvent(search: search));
  }

  bool shouldLoadMore(ScrollController scrollController) {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.8) {
      return true;
    }
    return false;
  }

  bool canLoadMore() => state.subjectState.canLoadMore;

  SubjectParm get currentParams =>
      state.subjectState.query as SubjectParm? ?? const SubjectParm();

  void clearError() {
    if (state.subjectState.isError) {
      emit(state.copyWith(subjectState: const PaginationState.initial()));
    } else if (state.subjectState.isErrorMore) {
      emit(
        state.copyWith(
          subjectState: PaginationState(
            state: state.subjectState.state,
            data: state.subjectState.data,
            meta: state.subjectState.meta,
            query: state.subjectState.query,
          ),
        ),
      );
    }
  }

  void reset() {
    emit(const SubjectStates());
  }
}
