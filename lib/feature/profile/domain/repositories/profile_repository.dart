import 'package:exam_app/config/base_response/result.dart';
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Result<ProfileEntity>> getProfileData();
  Future<Result<ProfileEntity>> updateProfile(ProfileEntity profile);
  Future<Result<String>> changePassword(String currentPassword, String newPassword, String confirmPassword);
}
