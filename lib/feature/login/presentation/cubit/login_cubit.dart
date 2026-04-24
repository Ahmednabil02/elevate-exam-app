import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../api/models/login_request.dart';
import '../../api/models/login_response.dart';
import '../../domain/use_cases/login_use_case.dart';

part 'login_states.dart';
part 'login_events.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  final LoginUseCase _loginUseCase;

  LoginCubit({required LoginUseCase loginUseCase})
    : _loginUseCase = loginUseCase,
      super(const LoginStates());

  Future<void> doIntent(LoginEvents event) async => switch (event) {
    LoginButtonEvent() => _login(event),
    TogglePasswordVisibilityEvent() => _togglePassword(),
  };

  Future<void> _login(LoginButtonEvent event) async {
    emit(state.copyWith(loginState: const BaseState.loading()));

    final result = await _loginUseCase.call(
      LoginRequest(email: event.email, password: event.password),
    );

    switch (result) {
      case Success():
        emit(state.copyWith(loginState: BaseState.success(result.data)));
      case Error():
        emit(state.copyWith(loginState: BaseState.error(result.exception)));
    }
  }

  void _togglePassword() {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }
}
