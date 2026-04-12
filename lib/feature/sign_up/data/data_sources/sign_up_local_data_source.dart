abstract interface class SignupLocalDataSourceContract {
  Future<void> saveUserToken(String token);
}
