part of 'login_cubit.dart';

sealed class LoginEvents extends Equatable {
  const LoginEvents();

  @override
  List<Object?> get props => [];
}

class LoginButtonEvent extends LoginEvents {
  final String email;
  final String password;

  const LoginButtonEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class TogglePasswordVisibilityEvent extends LoginEvents {
  const TogglePasswordVisibilityEvent();
}
