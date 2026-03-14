class AppStrings {
  AppStrings._();

  static const String appName = 'Online Exam';

  // Auth
  static const String login = 'Login';
  static const String signUp = 'Sign up';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String forgotPassword = 'Forgot password?';

  // Home / Exam
  static const String explore = 'Explore';
  static const String results = 'Results';
  static const String profile = 'Profile';
  static const String startExam = 'Start exam';
  static const String next = 'Next';
  static const String back = 'Back';
  static const String finish = 'Finish';
  static const String viewScore = 'View score';
  static const String timeOut = 'Time out!';

  // Errors
  static const String somethingWentWrong =
      'Something went wrong, please try again';
  static const String confirm = 'Confirm';
  static const String cancel = 'Cancel';
  static const String retry = 'Retry';
  static const String loading = 'Loading...';
  static const String success = 'Success';
  static const String error = 'Error';
  static const String noDataFound = 'No data found';
  static const String noInternetError = 'No internet connection';
  static const String serverError = 'Server error occurred';
  static const String cacheError = 'Cache error occurred';
  static const String unexpectedError = 'Unexpected error occurred';

  // API Failures
  static const String noInternet = 'No internet connection';
  static const String connectionTimeout = 'Connection timeout';
  static const String sendTimeout = 'Send timeout';
  static const String receiveTimeout = 'Receive timeout';
  static const String badCertificate = 'Bad certificate';
  static const String requestCancelled = 'Request cancelled';
  static const String connectionError = 'Connection error';
  static const String unknownError = 'Unknown error occurred';
  static const String apiServerError = 'Server error';
  static const String sessionExpired = 'Session expired, please login again';

  // Validations
  static const String passwordRequired = 'Please enter your password';
  static const String setPassword1ConditionError =
      'Add at least one lowercase letter to make it stronger';
  static const String setPassword2ConditionError =
      'Add at least one uppercase letter to make it stronger';
  static const String setPassword3ConditionError =
      'Add at least one number to make it stronger';
  static const String setPassword4ConditionError =
      'Add a special character to make it more secure';
  static const String setPassword5ConditionError =
      'Password should be between 6 and 30 characters';
  static const String confirmPassword = 'Please confirm your password';
  static const String confirmPasswordInvalid =
      'Passwords don\'t match, please try again';
  static const String phoneRequired = 'Please enter your phone number';
  static const String phoneInvalid = 'Please enter a valid phone number';
  static const String nameRequired = 'Please enter your name';
  static const String pinRequired = 'Please enter your PIN';
  static const String pinInvalid = 'Please enter a valid PIN';
  static const String profileImage = 'Please add a profile image';
  static const String emailRequired = 'Please enter your email';
  static const String emailInvalid = 'Please enter a valid email address';
  static const String usernameRequired = 'Please enter your username';

  // Resend Timer
  static const String didntReceiveCode = "Didn't receive code?";
  static const String resend = 'Resend';
  static const String resendIn = 'Resend in';

  // Forget Password
  static const String forgetPassword = 'Forget password';
  static const String emailVerification = 'Email verification';
  static const String resetPassword = 'Reset password';
  static const String enterEmailAssociated =
      'Please enter your email associated to your account';
  static const String enterYourEmail = 'Enter you email';
  static const String enterCodeSentToEmail =
      'Please enter your code that send to your email address';
  static const String invalidCode = 'Invalid code';
  static const String passwordMustContain =
      'Password must not be empty and must contain 6 characters with upper case letter and one number at least';
  static const String newPassword = 'New password';
  static const String enterYouPassword = 'Enter you password';
  static const String confirmPasswordLabel = 'Confirm password';
  static const String confirmPasswordPlaceholder = 'Confirm password';
  static const String continueText = 'Continue';
  static const String thisEmailIsNotValid = 'This Email is not valid';
  static const String passwordResetSuccessfully = 'Password reset successfully';
}
