import 'package:equatable/equatable.dart';

class ForgetPasswordParams extends Equatable {
  final String? email;
  final String? code;
  final String? newPassword;

  const ForgetPasswordParams({this.email, this.code, this.newPassword});

  factory ForgetPasswordParams.fromJson(Map<String, dynamic> json) =>
      ForgetPasswordParams(
        email: json['email'] as String?,
        code: json['resetCode'] as String?,
        newPassword: json['newPassword'] as String?,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (email != null) data['email'] = email;
    if (code != null) data['resetCode'] = code;
    if (newPassword != null) data['newPassword'] = newPassword;
    return data;
  }

  ForgetPasswordParams copyWith({
    String? email,
    String? code,
    String? newPassword,
  }) {
    return ForgetPasswordParams(
      email: email ?? this.email,
      code: code ?? this.code,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  @override
  List<Object?> get props => [email, code, newPassword];
}
