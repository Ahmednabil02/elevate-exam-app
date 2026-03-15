import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/validations/validations.dart';
import '../../../../core/values/app_strings.dart';
import '../../../../core/widgets/text_field/password_field.dart';
import '../cubit/sign_up_cubit.dart';

class PasswordRow extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController rePasswordController;

  const PasswordRow({
    super.key,
    required this.passwordController,
    required this.rePasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _PasswordField(controller: passwordController)),
        const SizedBox(width: 16),
        Expanded(
          child: _ConfirmPasswordField(
            controller: rePasswordController,
            passwordController: passwordController,
          ),
        ),
      ],
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;

  const _PasswordField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpStates>(
      buildWhen: (prev, curr) => prev.passwordVisible != curr.passwordVisible,
      builder: (context, state) {
        return PasswordField(
          controller: controller,
          obscureText: !state.passwordVisible,
          labelText: AppStrings.password,
          textInputAction: TextInputAction.next,
          validator: Validations.validatePassword,
          toggleVisibility: () => context.read<SignUpCubit>().doIntent(
            const TogglePasswordVisibilityEvent(isConfirmPassword: false),
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController passwordController;

  const _ConfirmPasswordField({
    required this.controller,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpStates>(
      buildWhen: (prev, curr) =>
          prev.confirmPasswordVisible != curr.confirmPasswordVisible,
      builder: (context, state) {
        return PasswordField(
          controller: controller,
          obscureText: !state.confirmPasswordVisible,
          labelText: AppStrings.confirmPasswordLabel,
          textInputAction: TextInputAction.next,
          validator: (v) {
            if (v?.isEmpty ?? true) return AppStrings.confirmPasswordRequired;
            if (v != passwordController.text) return AppStrings.passwordsDoNotMatch;
            return null;
          },
          toggleVisibility: () => context.read<SignUpCubit>().doIntent(
            const TogglePasswordVisibilityEvent(isConfirmPassword: true),
          ),
        );
      },
    );
  }
}
