part of 'login_cubit.dart';

class LoginStates extends Equatable {
  final BaseState<LoginResponse> loginState;
  final bool passwordVisible;

  const LoginStates({
    this.loginState = const BaseState.initial(),
    this.passwordVisible = false,
  });

  @override
  List<Object?> get props => [loginState, passwordVisible];

  LoginStates copyWith({
    BaseState<LoginResponse>? loginState,
    bool? passwordVisible,
  }) {
    return LoginStates(
      loginState: loginState ?? this.loginState,
      passwordVisible: passwordVisible ?? this.passwordVisible,
    );
  }
}
