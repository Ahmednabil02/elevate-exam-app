class EndPoints {
  static const String baseUrl = "https://exam.elevateegy.com/api/v1";
  // static const String baseImageUrl = "https://exam.elevateegy.com/images/";

  // Forget Password
  static const String forgetPassword = "/auth/forgotPassword";
  static const String verifyEmailCode = "/auth/verifyResetCode";
  static const String resetPassword = "/auth/resetPassword";
  static const String signupEndpoint = "/auth/signup";
  // added login endpoint
  static const String login = "/auth/signin";

  // Profile
  static const String getProfileData = "/auth/profileData";
  static const String updateProfile = "/auth/editProfile";
  static const String logout = "/auth/logout";

  // Change Password Endpoint
  static const String changePassword = "/auth/changePassword";
}

class Apikeys {
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  static const String userId = 'userId';
  static const String rememberMe = 'rememberMe';
}
