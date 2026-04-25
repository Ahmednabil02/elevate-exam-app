import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import '../../domain/entities/profile_entity.dart';

class ProfileState extends Equatable {
  final BaseState<ProfileEntity> profileState;
  final BaseState<ProfileEntity> updateState;
  final BaseState<String> changePasswordState;
  final File? pickedImage;

  const ProfileState({
    this.profileState = const BaseState.initial(),
    this.updateState = const BaseState.initial(),
    this.changePasswordState = const BaseState.initial(),
    this.pickedImage,
  });

  ProfileState copyWith({
    BaseState<ProfileEntity>? profileState,
    BaseState<ProfileEntity>? updateState,
    BaseState<String>? changePasswordState,
    File? pickedImage,
    bool clearPickedImage = false,
  }) {
    return ProfileState(
      profileState: profileState ?? this.profileState,
      updateState: updateState ?? this.updateState,
      changePasswordState: changePasswordState ?? this.changePasswordState,
      pickedImage: clearPickedImage ? null : (pickedImage ?? this.pickedImage),
    );
  }

  @override
  List<Object?> get props => [
        profileState,
        updateState,
        changePasswordState,
        pickedImage,
      ];
}
