part of 'forget_password_cubit.dart';

class ForgetPasswordStates extends Equatable {
  final int currentScreen;
  final BaseState<void> sendOtpToEmailState;
  final BaseState<void> verifyOtpState;
  final BaseState<void> resetPasswordState;
  final bool newPasswordVisible;
  final bool confirmPasswordVisible;
  final String? email;

  const ForgetPasswordStates({
    this.currentScreen = 0,
    this.sendOtpToEmailState = const BaseState.initial(),
    this.verifyOtpState = const BaseState.initial(),
    this.resetPasswordState = const BaseState.initial(),
    this.newPasswordVisible = false,
    this.confirmPasswordVisible = false,
    this.email,
  });

  @override
  List<Object?> get props => [
    currentScreen,
    sendOtpToEmailState,
    verifyOtpState,
    resetPasswordState,
    newPasswordVisible,
    email,
    confirmPasswordVisible,
  ];

  ForgetPasswordStates copyWith({
    int? currentScreen,
    bool? confirmPasswordVisible,
    bool? newPasswordVisible,
    bool? isPasswordReset,
    BaseState? sendOtpToEmailState,
    BaseState? verifyOtpState,
    BaseState? resetPasswordState,
    String? email,
    bool clearEmail = false,
  }) {
    return ForgetPasswordStates(
      currentScreen: currentScreen ?? this.currentScreen,
      sendOtpToEmailState: sendOtpToEmailState ?? this.sendOtpToEmailState,
      verifyOtpState: verifyOtpState ?? this.verifyOtpState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      newPasswordVisible: newPasswordVisible ?? this.newPasswordVisible,
      confirmPasswordVisible:
          confirmPasswordVisible ?? this.confirmPasswordVisible,
      email: clearEmail ? null : email ?? this.email,
    );
  }
}
