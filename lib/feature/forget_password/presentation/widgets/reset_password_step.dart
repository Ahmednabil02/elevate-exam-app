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

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  late final ForgetPasswordCubit cubit;
  late final TextEditingController newPasswordController;
  late final TextEditingController confirmPasswordController;
  late final GlobalKey<FormState> formKey;

  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ForgetPasswordCubit>();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      cubit.doIntent(ResetPasswordEvent(password: newPasswordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            PasswordField(
              controller: newPasswordController,
              labelText: AppStrings.newPassword,
              validator: Validations.validatePassword,
              textInputAction: TextInputAction.next,
              obscureText: !_newPasswordVisible,
              toggleVisibility: () {
                setState(() {
                  _newPasswordVisible = !_newPasswordVisible;
                });
              },
            ),
            const SizedBox(height: 24),
            PasswordField(
              controller: confirmPasswordController,
              labelText: AppStrings.confirmPasswordLabel,
              validator: (value) => Validations.validatePasswordVerification(
                value,
                newPasswordController.text,
              ),
              textInputAction: TextInputAction.done,
              obscureText: !_confirmPasswordVisible,
              toggleVisibility: () {
                setState(() {
                  _confirmPasswordVisible = !_confirmPasswordVisible;
                });
              },
              onFieldSubmitted: (_) => _onSubmit(),
            ),
            const SizedBox(height: 48),
            _SubmitButton(onSubmit: _onSubmit),
          ],
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final void Function() onSubmit;

  const _SubmitButton({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
      listenWhen: (previous, current) =>
          previous.resetPasswordState != current.resetPasswordState,
      listener: (context, state) {
        if (state.resetPasswordState.isSuccess) {
          context.showSuccessMessage(
            state: state.resetPasswordState,
            massage: AppStrings.passwordResetSuccessfully,
            onSuccess: () => context.go(Routes.login),
          );
        } else if (state.resetPasswordState.isError) {
          context.showErrorMessage(state.resetPasswordState);
        }
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
