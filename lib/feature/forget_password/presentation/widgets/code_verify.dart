import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/base_state/state_types.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_font_style.dart';
import '../../../../core/values/app_strings.dart';
import '../../../../core/widgets/resend_timer_widget.dart';
import '../../../../core/widgets/text_field/otp_input_field.dart';
import '../../domain/entity/forget_password_params.dart';
import '../cubit/forget_password_cubit.dart';

class CodeVerify extends StatelessWidget {
  const CodeVerify({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();
    final codeController = TextEditingController();

    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
      buildWhen: (previous, current) =>
          previous.verifyOtpState != current.verifyOtpState,
      builder: (context, state) {
        return Column(
          children: [
            const _Title(),
            const SizedBox(height: 8),
            const _Subtitle(),
            const SizedBox(height: 32),
            OtpInputField(
              controller: codeController,
              length: 6,
              hasError: state.verifyOtpState.state == BaseStateType.error,
              onCompleted: (code) {
                cubit.doIntent(VerifyOtpEvent(otp: code));
              },
            ),
            if (state.verifyOtpState.state == BaseStateType.error) ...[
              const SizedBox(height: 8),
              const _ErrorMessage(),
            ],
            const SizedBox(height: 16),
            ResendTimerWidget(
              onResend: () {
                if (state.email != null) {
                  cubit.doIntent(
                    SendOtpToEmailEvent(
                      params: ForgetPasswordParams(email: state.email!),
                    ),
                  );
                }
              },
              durationInSeconds: 60,
            ),
          ],
        );
      },
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Text(
        AppStrings.emailVerification,
        style: AppFontStyle.medium18(context).copyWith(color: AppColors.black),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Text(
        AppStrings.enterCodeSentToEmail,
        style: AppFontStyle.regular14(
          context,
        ).copyWith(color: AppColors.gray53),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, color: AppColors.red, size: 16),
        const SizedBox(width: 4),
        Text(
          AppStrings.invalidCode,
          style: AppFontStyle.regular12(context).copyWith(color: AppColors.red),
        ),
      ],
    );
  }
}
