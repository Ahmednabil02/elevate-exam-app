part of 'forget_password_cubit.dart';
sealed class ForgetPasswordEvents {
  const ForgetPasswordEvents();
}

class SendOtpToEmailEvent extends ForgetPasswordEvents {
  final ForgetPasswordParams params;
  const SendOtpToEmailEvent({required this.params});
}

class VerifyOtpEvent extends ForgetPasswordEvents {
  final String otp;

  const VerifyOtpEvent({required this.otp});
}

class TogglePasswordEvent extends ForgetPasswordEvents {
  final bool isConfirmPassword;

  const TogglePasswordEvent({required this.isConfirmPassword});
}

class ResetPasswordEvent extends ForgetPasswordEvents {
  String? password;
}