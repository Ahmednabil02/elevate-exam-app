class ApiEndpoints {
  static const String baseUrl = 'https://exam.elevateegy.com/';

  // Auth Group
  static const String authGroup = '${baseUrl}api/v1/auth/';
  static const String login = '${authGroup}signin';
  static const String register = '${authGroup}signup';
  static const String forgotPassword = '${authGroup}forgotPassword';
  static const String verifyResetCode = '${authGroup}verifyResetCode';
  static const String resetPassword = '${authGroup}resetPassword';
  static const String changePassword = '${authGroup}changePassword';
  static const String logout = '${authGroup}logout';
  static const String editProfile = '${authGroup}editProfile';
  static const String profileInfo = '${authGroup}profileData';

  // Subjects Group
  static const String subjectsGroup = '${baseUrl}api/v1/subjects/';
  static const String allSubjects = subjectsGroup;

  // Exams Group
  static const String examsGroup = '${baseUrl}api/v1/exams/';
  static const String examsOnSubject = examsGroup;

  // Questions Group
  static const String questionsGroup = '${baseUrl}api/v1/questions/';
  static const String questionsOnExam = questionsGroup;
}

class ApiKey {
  static const String status = 'status';
  static const String errorMessage = 'message';
  static const String token = 'token';
}
