import 'package:flutter/material.dart';

import '../../../../core/validations/validations.dart';
import '../../../../core/values/app_strings.dart';
import '../../../../core/widgets/text_field/password_field.dart';

class PasswordRow extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController rePasswordController;

  const PasswordRow({
    super.key,
    required this.passwordController,
    required this.rePasswordController,
  });

  @override
  State<PasswordRow> createState() => _PasswordRowState();
}

class _PasswordRowState extends State<PasswordRow> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PasswordField(
            controller: widget.passwordController,
            obscureText: !_passwordVisible,
            labelText: AppStrings.password,
            textInputAction: TextInputAction.next,
            validator: Validations.validatePassword,
            toggleVisibility: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: PasswordField(
            controller: widget.rePasswordController,
            obscureText: !_confirmPasswordVisible,
            labelText: AppStrings.confirmPasswordLabel,
            textInputAction: TextInputAction.next,
            validator: (v) {
              if (v?.isEmpty ?? true) return AppStrings.confirmPasswordRequired;
              if (v != widget.passwordController.text) {
                return AppStrings.passwordsDoNotMatch;
              }
              return null;
            },
            toggleVisibility: () {
              setState(() {
                _confirmPasswordVisible = !_confirmPasswordVisible;
              });
            },
          ),
        ),
      ],
    );
  }
}
