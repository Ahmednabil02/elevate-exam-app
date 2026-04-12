part of 'sign_up_cubit.dart';

class SignUpStates extends Equatable {
  final BaseState<UserEntity> signUpState;

  const SignUpStates({this.signUpState = const BaseState.initial()});

  @override
  List<Object?> get props => [signUpState];

  SignUpStates copyWith({BaseState<UserEntity>? signUpState}) {
    return SignUpStates(signUpState: signUpState ?? this.signUpState);
  }
}
