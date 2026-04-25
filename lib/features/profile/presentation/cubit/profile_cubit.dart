import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/config/uses_cases/use_cases.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/use_cases/change_password_use_case.dart';
import '../../domain/use_cases/get_profile_use_case.dart';
import '../../domain/use_cases/update_profile_use_case.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;
  final ImagePicker _imagePicker = ImagePicker();

  ProfileCubit(
    this._getProfileUseCase,
    this._updateProfileUseCase,
    this._changePasswordUseCase,
  ) : super(const ProfileState());

  Future<void> pickImage() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(pickedImage: File(image.path)));
    }
  }

  Future<void> getProfile() async {
    emit(state.copyWith(profileState: const BaseState.loading()));
    final result = await _getProfileUseCase(const NoParams());
    result.when(
      success: (data) => emit(state.copyWith(profileState: BaseState.success(data))),
      error: (exception) => emit(state.copyWith(profileState: BaseState.error(exception))),
    );
  }

  Future<void> updateProfile(ProfileEntity profile) async {
    emit(state.copyWith(updateState: const BaseState.loading()));
    final result = await _updateProfileUseCase(profile);
    result.when(
      success: (data) {
        emit(state.copyWith(
          updateState: BaseState.success(data),
          profileState: BaseState.success(data), // Update the main profile state too
        ));
      },
      error: (exception) => emit(state.copyWith(updateState: BaseState.error(exception))),
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(changePasswordState: const BaseState.loading()));
    final result = await _changePasswordUseCase(ChangePasswordParams(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    ));
    result.when(
      success: (data) => emit(state.copyWith(changePasswordState: BaseState.success(data))),
      error: (exception) => emit(state.copyWith(changePasswordState: BaseState.error(exception))),
    );
  }
}
