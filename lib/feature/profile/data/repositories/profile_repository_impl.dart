import 'dart:developer';

import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/core/values/app_assets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:exam_app/config/api/end_points.dart';
import 'package:exam_app/core/helper/jwt_utils.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../api/profile_api_service.dart';
import '../models/profile_model.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiService _apiService;
  final FlutterSecureStorage _fss;

  ProfileRepositoryImpl(this._apiService, this._fss);

  static const _defaultProfile = ProfileModel(
    modelId: "default_user_123",
    username: "Guest_User",
    firstName: "First",
    lastName: "Last",
    email: "guest@example.com",
    phone: "00000000000",
    role: "user",
    image: AppAssets.defaultProfile,
  );

  @override
  Future<Result<ProfileEntity>> getProfileData() async {
    try {
      final response = await _apiService.getProfileData();
      debugPrint("Profile data loaded successfully from API");

      return Success(data: response.user);
    } catch (e) {
      debugPrint("API call failed, trying to load from token... Error: $e");
      try {
        final token = await _fss.read(key: APIkeys.accessToken);
        if (token != null) {
          final data = JwtUtils.decodeToken(token);
          debugPrint("Profile data successfully extracted from Token");
          return Success(
            data: ProfileModel(
              modelId: data['id'] ?? data['_id'] ?? data['userId'],
              username: data['username'] ?? data['userName'],
              firstName: data['firstName'],
              lastName: data['lastName'],
              email: data['email'],
              role: data['role'],
            ),
          );
        }
        debugPrint("Token found but decoding failed or data missing");
        return const Success(data: _defaultProfile);
      } catch (e) {
        debugPrint("Error reading or decoding token: $e");
        return const Success(data: _defaultProfile);
      }
    }
  }

  @override
  Future<Result<ProfileEntity>> updateProfile(ProfileEntity profile) async {
    try {
      final model = ProfileModel(
        modelId: profile.id,
        username: profile.username,
        firstName: profile.firstName,
        lastName: profile.lastName,
        email: profile.email,
        phone: profile.phone,
        role: profile.role,
        image: profile.image,
      );
      final response = await _apiService.updateProfile(model);
      return Success(data: response);
    } catch (e, s) {
      log("Error updating profile: $e", stackTrace: s);
      return Error(exception: Exception(e.toString()));
    }
  }

  @override
  Future<Result<String>> changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      if (kDebugMode) {
        return const Success(data: "Password changed successfully (Mocked)");
      }
      final response = await _apiService.changePassword({
        "currentPassword": currentPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      });
      return Success(data: response);
    } catch (e) {
      return Error(exception: Exception(e.toString()));
    }
  }
}
