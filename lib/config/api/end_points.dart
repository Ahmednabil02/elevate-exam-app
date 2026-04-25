abstract class EndPoints {
  static const String baseUrl = "https://exam.elevateegy.com/api/v1";
  static const String forgetPassword = "/auth/forgotPassword";
  static const String verifyEmailCode = "/auth/verifyResetCode";
  static const String resetPassword = "/auth/resetPassword";
  static const String signupEndpoint = "/auth/signup";
  static const String login = "/auth/signin";
  static const String getProfileData = "/auth/profileData";
  static const String updateProfile = "/auth/profile";
  static const String logout = "/auth/logout";
  static const String changePassword = "/auth/changePassword";

  // Exams
  static const String exams = "/exams";
  static const String subjects = "/subjects";

  // Questions
  static const String questions = "/questions";
}

class APIkeys {
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  static const String userId = 'userId';
  static const String rememberMe = 'rememberMe';
  static const String exam = 'exam';
}
