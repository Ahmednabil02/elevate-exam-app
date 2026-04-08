import 'dart:developer';
import 'package:exam_app/config/base_response/result.dart' as api_result;
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../domain/models/subject_entity.dart';
import '../../domain/usecases/get_subjects_use_case.dart';

part 'subject_state.dart';

@injectable
class SubjectCubit extends Cubit<SubjectStates> {
  final GetSubjectsUseCase _getSubjectsUseCase;

  SubjectCubit(this._getSubjectsUseCase) : super(const SubjectStates());

  Future<void> fetchSubjects() async {
    log("SubjectCubit: Fetching subjects...");
    emit(state.copyWith(subjectState: const BaseState.loading()));
    final result = await _getSubjectsUseCase.execute();
    switch (result) {
      case api_result.Success(:final data):
        log("SubjectCubit: Success, fetched ${data?.length} subjects");
        emit(
          state.copyWith(
            subjectState: BaseState.success(data ?? []),
          ),
        );
      case api_result.Error(:final exception):
        log("SubjectCubit: Error, exception: $exception");
        emit(
          state.copyWith(
            subjectState: BaseState.error(exception),
          ),
        );
    }
  }
}
