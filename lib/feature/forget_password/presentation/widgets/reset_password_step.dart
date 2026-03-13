import 'package:exam_app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/validations/validations.dart';
import '../../../../core/values/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_toast.dart';
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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
              buildWhen: (previous, current) =>
                  previous.newPasswordVisible != current.newPasswordVisible,
              builder: (context, state) {
                return PasswordField(
                  controller: newPasswordController,
                  labelText: AppStrings.newPassword,
                  validator: Validations.validatePassword,
                  textInputAction: TextInputAction.next,
                  obscureText: !state.newPasswordVisible,
                  toggleVisibility: () => cubit.doIntent(
                    TogglePasswordEvent(isConfirmPassword: false),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
              buildWhen: (previous, current) =>
                  previous.confirmPasswordVisible !=
                  current.confirmPasswordVisible,
              builder: (context, state) {
                return PasswordField(
                  controller: confirmPasswordController,
                  labelText: AppStrings.confirmPasswordLabel,
                  validator: (value) =>
                      Validations.validatePasswordVerification(
                        value,
                        newPasswordController.text,
                      ),
                  textInputAction: TextInputAction.done,
                  obscureText: !state.confirmPasswordVisible,
                  toggleVisibility: () => cubit.doIntent(
                    TogglePasswordEvent(isConfirmPassword: true),
                  ),
                  onFieldSubmitted: (_) {
                    if (formKey.currentState?.validate() ?? false) {
                      cubit.doIntent(
                        ResetPasswordEvent()
                          ..password = newPasswordController.text,
                      );
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 48),
            BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
              listenWhen: (previous, current) =>
                  previous.resetPasswordState != current.resetPasswordState,
              listener: (context, state) {
                if (state.resetPasswordState.isSuccess) {
                  CustomToast.showSuccess(
                    context: context,
                    message: 'Password reset successfully',
                  );
                  context.go(Routes.home);
                } else if (state.resetPasswordState.isError) {
                  CustomToast.showError(
                    context: context,
                    message:
                        state.resetPasswordState.exception?.toString() ??
                        AppStrings.somethingWentWrong,
                  );
                }
              },
              buildWhen: (previous, current) =>
                  previous.resetPasswordState != current.resetPasswordState,
              builder: (context, state) {
                return CustomButton(
                  text: AppStrings.continueText,
                  isLoading: state.resetPasswordState.isLoading,
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      cubit.doIntent(
                        ResetPasswordEvent()
                          ..password = newPasswordController.text,
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
