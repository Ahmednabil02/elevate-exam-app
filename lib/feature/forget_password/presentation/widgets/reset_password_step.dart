import 'package:exam_app/config/helper/extensions/base_state/show_error_massage.dart';
import 'package:exam_app/config/helper/extensions/base_state/show_success_massage.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/validations/validations.dart';
import '../../../../core/values/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/text_field/password_field.dart';
import '../cubit/forget_password_cubit.dart';

class ResetPasswordStep extends StatefulWidget {
  const ResetPasswordStep({super.key});

  @override
  State<ResetPasswordStep> createState() => _ResetPasswordStepState();
}

class _ResetPasswordStepState extends State<ResetPasswordStep> {
  late final ForgetPasswordCubit cubit;

  late final TextEditingController newPasswordController;

  late final TextEditingController confirmPasswordController;

  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    cubit = context.read<ForgetPasswordCubit>();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      cubit.doIntent(ResetPasswordEvent(password: newPasswordController.text));
    }
  }

  void _toggleVisibility(bool isConfirmPassword) {
    cubit.doIntent(TogglePasswordEvent(isConfirmPassword: isConfirmPassword));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            _NewPassword(
              newPasswordController: newPasswordController,
              toggleVisibility: () => _toggleVisibility(false),
            ),
            const SizedBox(height: 24),
            _ConfirmNewPassword(
              confirmPasswordController: confirmPasswordController,
              newPassword: newPasswordController.text,
              onSubmit: (_) => _onSubmit(),
              toggleVisibility: () => _toggleVisibility(true),
            ),
            const SizedBox(height: 48),
            _SubmitButton(onSubmit: () => _onSubmit()),
          ],
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final void Function() onSubmit;

  const _SubmitButton({required this.onSubmit});
//
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
      listenWhen: (previous, current) =>
          previous.resetPasswordState != current.resetPasswordState,
      listener: (context, state) {
        context.showSuccessMessage(
          state: state.resetPasswordState,
          massage: AppStrings.passwordResetSuccessfully,
          onSuccess: () => context.go(Routes.home),
        );
        context.showErrorMessage(state.resetPasswordState);
      },
      buildWhen: (previous, current) =>
          previous.resetPasswordState != current.resetPasswordState,
      builder: (context, state) => CustomButton(
        text: AppStrings.continueText,
        isLoading: state.resetPasswordState.isLoading,
        onPressed: onSubmit,
      ),
    );
  }
}

class _ConfirmNewPassword extends StatelessWidget {
  final TextEditingController confirmPasswordController;
  final String newPassword;
  final void Function(String)? onSubmit;
  final void Function()? toggleVisibility;

  const _ConfirmNewPassword({
    required this.confirmPasswordController,
    required this.newPassword,
    required this.onSubmit,
    required this.toggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
      buildWhen: (previous, current) =>
          previous.confirmPasswordVisible != current.confirmPasswordVisible,
      builder: (context, state) {
        return PasswordField(
          controller: confirmPasswordController,
          labelText: AppStrings.confirmPasswordLabel,
          validator: (value) =>
              Validations.validatePasswordVerification(value, newPassword),
          textInputAction: TextInputAction.done,
          obscureText: !state.confirmPasswordVisible,
          toggleVisibility: toggleVisibility,
          onFieldSubmitted: onSubmit,
        );
      },
    );
  }
}

class _NewPassword extends StatelessWidget {
  final TextEditingController newPasswordController;
  final void Function()? toggleVisibility;

  const _NewPassword({
    required this.newPasswordController,
    required this.toggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
      buildWhen: (previous, current) =>
          previous.newPasswordVisible != current.newPasswordVisible,
      builder: (context, state) {
        return PasswordField(
          controller: newPasswordController,
          labelText: AppStrings.newPassword,
          validator: Validations.validatePassword,
          textInputAction: TextInputAction.next,
          obscureText: !state.newPasswordVisible,
          toggleVisibility: toggleVisibility,
        );
      },
    );
  }
}
