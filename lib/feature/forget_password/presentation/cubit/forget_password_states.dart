part of 'forget_password_cubit.dart';

class ForgetPasswordStates extends Equatable {
  final int currentScreen;
  final BaseState<void> sendOtpToEmailState;
  final BaseState<void> verifyOtpState;
  final BaseState<void> resetPasswordState;
  final String? email;

  const ForgetPasswordStates({
    this.currentScreen = 0,
    this.sendOtpToEmailState = const BaseState.initial(),
    this.verifyOtpState = const BaseState.initial(),
    this.resetPasswordState = const BaseState.initial(),
    this.email,
  });

  @override
  List<Object?> get props => [
    currentScreen,
    sendOtpToEmailState,
    verifyOtpState,
    resetPasswordState,
    email,
  ];

  ForgetPasswordStates copyWith({
    int? currentScreen,
    BaseState<void>? sendOtpToEmailState,
    BaseState<void>? verifyOtpState,
    BaseState<void>? resetPasswordState,
    String? email,
    bool clearEmail = false,
  }) {
    return ForgetPasswordStates(
      currentScreen: currentScreen ?? this.currentScreen,
      sendOtpToEmailState: sendOtpToEmailState ?? this.sendOtpToEmailState,
      verifyOtpState: verifyOtpState ?? this.verifyOtpState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      email: clearEmail ? null : email ?? this.email,
    );
  }
}
