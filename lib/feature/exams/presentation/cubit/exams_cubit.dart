import 'package:equatable/equatable.dart';
import 'package:exam_app/config/base_state/pagination_state.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exams/domain/entities/exams_parms.dart';
import 'package:exam_app/feature/exams/domain/use_cases/get_exams_by_subject_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'exams_events.dart';

part 'exams_states.dart';

@injectable
class ExamsCubit extends Cubit<ExamsStates> {
  final GetExamsBySubjectUseCase _getExamsBySubjectUseCase;

  ExamsCubit({required GetExamsBySubjectUseCase getExamsBySubjectUseCase})
    : _getExamsBySubjectUseCase = getExamsBySubjectUseCase,
      super(const ExamsStates());

  @override
  void emit(ExamsStates state) {
    if (!isClosed) super.emit(state);
  }

  Future<void> doIntent(ExamsEvents event) async => switch (event) {
    GetExamsEvent() => _getExams(event),
    LoadMoreExamsEvent() => _loadMore(event),
  };

  Future<void> _getExams(GetExamsEvent event) async {
    if (state.examsState.isLoading) return;
final params = ExamParms(subjectId: event.subjectId, page: 1);
    emit(
      state.copyWith(
        examsState: state.examsState.toLoading(query: params),
      ),
    );

    final result = await _getExamsBySubjectUseCase.call(params);

    result.when(
      success: (data) {
        if (data != null) {
          emit(
            state.copyWith(
              examsState: state.examsState.toSuccessFromEntity(data),
            ),
          );
        } else {
          emit(
            state.copyWith(
              examsState: state.examsState.toError(
                Exception('No data received'),
              ),
            ),
          );
        }
      },
      error: (exception) {
        emit(
          state.copyWith(
            examsState: state.examsState.toError(
              exception ?? Exception('Unknown error'),
            ),
          ),
        );
      },
    );
  }

  Future<void> _loadMore(LoadMoreExamsEvent event) async {
    if (!state.examsState.canLoadMore) return;

    emit(state.copyWith(examsState: state.examsState.toLoadingMore()));

    final result = await _getExamsBySubjectUseCase.call(event.params);

    result.when(
      success: (data) {
        if (data != null) {
          emit(
            state.copyWith(
              examsState: state.examsState.toSuccessFromEntity(data),
            ),
          );
        } else {
          emit(
            state.copyWith(
              examsState: state.examsState.toErrorMore(
                Exception('No data received'),
              ),
            ),
          );
        }
      },
      error: (exception) {
        emit(
          state.copyWith(
            examsState: state.examsState.toErrorMore(
              exception ?? Exception('Unknown error'),
            ),
          ),
        );
      },
    );
  }

  Future<void> refreshExams(String? subjectId) async {
    ExamParms params = state.examsState.query as ExamParms;
    params.copyWith(page: 1, subjectId: subjectId);

    await doIntent(GetExamsEvent(subjectId: subjectId));
  }

  void clearError() {
    if (state.examsState.isError) {
      emit(state.copyWith(examsState: const PaginationState.initial()));
    } else if (state.examsState.isErrorMore) {
      emit(
        state.copyWith(
          examsState: PaginationState(
            state: state.examsState.state,
            data: state.examsState.data,
            meta: state.examsState.meta,
            query: state.examsState.query,
          ),
        ),
      );
    }
  }

  void reset() {
    emit(const ExamsStates());
  }
}
