import 'package:equatable/equatable.dart';
import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/sign_up/domain/models/sign_up_post_entity.dart';
import 'package:exam_app/feature/sign_up/domain/models/user_entity.dart';
import 'package:exam_app/feature/sign_up/domain/usecases/sign_up_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'sign_up_events.dart';
part 'sign_up_states.dart';

@injectable
class SignUpCubit extends Cubit<SignUpStates> {
  final SignUpUserUseCase _signUpUserUseCase;

  SignUpCubit({required SignUpUserUseCase signUpUserUseCase})
    : _signUpUserUseCase = signUpUserUseCase,
      super(const SignUpStates());

  Future<void> doIntent(SignUpEvents event) async => switch (event) {
    SignUpUserEvent() => _signUpUser(event),
    TogglePasswordVisibilityEvent() => _togglePasswordVisibility(event),
  };

  Future<void> _signUpUser(SignUpUserEvent signUpEvent) async {
    emit(state.copyWith(signUpState: BaseState.loading()));

    final result = await _signUpUserUseCase.call(signUpEvent.params);
    switch (result) {
      case Success():
        emit(state.copyWith(signUpState: BaseState.success(result.data)));
      case Error():
        emit(state.copyWith(signUpState: BaseState.error(result.exception)));
    }
  }

  Future<void> _togglePasswordVisibility(
    TogglePasswordVisibilityEvent event,
  ) async {
    if (event.isConfirmPassword) {
      emit(
        state.copyWith(confirmPasswordVisible: !state.confirmPasswordVisible),
      );
    } else {
      emit(state.copyWith(passwordVisible: !state.passwordVisible));
    }
  }
}
