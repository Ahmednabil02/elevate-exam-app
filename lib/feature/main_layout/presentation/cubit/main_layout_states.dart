import 'package:equatable/equatable.dart';
import 'package:exam_app/config/base_state/base_state.dart';

class MainLayoutStates extends Equatable {
  final BaseState<void> logoutState;
  const MainLayoutStates({this.logoutState = const BaseState<void>.initial()});

  MainLayoutStates copyWith({BaseState<void>? logoutState}) {
    return MainLayoutStates(logoutState: logoutState ?? this.logoutState);
  }

  @override
  List<Object?> get props => [logoutState];
}
