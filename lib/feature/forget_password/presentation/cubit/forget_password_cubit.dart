import 'package:equatable/equatable.dart';
import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/forget_password/domain/entity/forget_password_params.dart';
import 'package:exam_app/feature/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:exam_app/feature/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:exam_app/feature/forget_password/domain/use_cases/verify_reset_code_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'forget_password_events.dart';
part 'forget_password_states.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  final SendOtpToEmailUseCase _sendOtpToEmailUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  ForgetPasswordCubit({
    required SendOtpToEmailUseCase sendOtpToEmailUseCase,
    required VerifyOtpUseCase verifyOtpUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
  }) : _sendOtpToEmailUseCase = sendOtpToEmailUseCase,
       _verifyOtpUseCase = verifyOtpUseCase,
       _resetPasswordUseCase = resetPasswordUseCase,
       super(const ForgetPasswordStates());

  Future<void> doIntent(ForgetPasswordEvents event) async => switch (event) {
    SendOtpToEmailEvent() => _sendOtpToEmail(event),
    VerifyOtpEvent() => _verifyOtp(event),
    ResetPasswordEvent() => _resetPassword(event),
  };

  Future<void> _sendOtpToEmail(SendOtpToEmailEvent sendEvent) async {
    emit(
      state.copyWith(
        sendOtpToEmailState: BaseState.loading(),
        clearEmail: true,
      ),
    );

    final result = await _sendOtpToEmailUseCase.call(sendEvent.params);
    switch (result) {
      case Success<void>():
        emit(
          state.copyWith(
            sendOtpToEmailState: BaseState.success(result),
            currentScreen: 1,
            email: sendEvent.params.email,
          ),
        );
        _updateCurrentStep(state.currentScreen);
      case Error<void>():
        emit(
          state.copyWith(
            sendOtpToEmailState: BaseState.error(result.exception),
          ),
        );
    }
  }

  Future<void> _verifyOtp(VerifyOtpEvent verifyEvent) async {
    emit(state.copyWith(verifyOtpState: BaseState.loading()));
    final result = await _verifyOtpUseCase.call(
      ForgetPasswordParams(code: verifyEvent.otp),
    );
    switch (result) {
      case Success<void>():
        emit(
          state.copyWith(
            currentScreen: 2,
            verifyOtpState: BaseState.success(result),
          ),
        );
        _updateCurrentStep(state.currentScreen);
      case Error<void>():
        emit(state.copyWith(verifyOtpState: BaseState.error(result.exception)));
    }
  }

  Future<void> _resetPassword(ResetPasswordEvent resetEvent) async {
    emit(state.copyWith(resetPasswordState: BaseState.loading()));

    final result = await _resetPasswordUseCase.call(
      ForgetPasswordParams(
        email: state.email,
        newPassword: resetEvent.password,
      ),
    );
    switch (result) {
      case Success<void>():
        emit(
          state.copyWith(
            resetPasswordState: BaseState.success(result),
            clearEmail: true,
          ),
        );
      case Error<void>():
        emit(
          state.copyWith(resetPasswordState: BaseState.error(result.exception)),
        );
    }
  }

  void _updateCurrentStep(int step) {
    emit(state.copyWith(currentScreen: step));
  }
}
