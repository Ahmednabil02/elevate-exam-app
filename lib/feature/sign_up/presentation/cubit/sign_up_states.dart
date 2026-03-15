part of 'sign_up_cubit.dart';

class SignUpStates extends Equatable {
  final BaseState<UserEntity> signUpState;
  final bool passwordVisible;
  final bool confirmPasswordVisible;

  const SignUpStates({
    this.signUpState = const BaseState.initial(),
    this.passwordVisible = false,
    this.confirmPasswordVisible = false,
  });

  @override
  List<Object?> get props => [
    signUpState,
    passwordVisible,
    confirmPasswordVisible,
  ];

  SignUpStates copyWith({
    BaseState<UserEntity>? signUpState,
    bool? passwordVisible,
    bool? confirmPasswordVisible,
  }) {
    return SignUpStates(
      signUpState: signUpState ?? this.signUpState,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      confirmPasswordVisible:
          confirmPasswordVisible ?? this.confirmPasswordVisible,
    );
  }
}
