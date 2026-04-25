import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/main_layout/domain/use_cases/logout_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'main_layout_events.dart';
import 'main_layout_states.dart';

@injectable
class MainLayoutCubit extends Cubit<MainLayoutStates> {
  MainLayoutCubit(this._logoutUseCase) : super(const MainLayoutStates());
  final LogoutUseCase _logoutUseCase;
  void doIndented(MainLayoutEvents event) {
    switch (event) {
      case LogoutEvent():
        _logout();
        break;
    }
  }

  void _logout() async {
    emit(state.copyWith(logoutState: const BaseState.loading()));
    final result = await _logoutUseCase();
    switch (result) {
      case Success():
        emit(state.copyWith(logoutState: const BaseState.success(null)));
        break;
      case Error():
        emit(state.copyWith(logoutState: BaseState.error(result.exception)));
        break;
    }
  }
}
