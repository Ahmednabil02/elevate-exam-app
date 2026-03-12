import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/base_state/state_types.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_font_style.dart';
import '../../../../core/values/app_strings.dart';
import '../../../../core/widgets/custom_toast.dart';
import '../../../../core/widgets/resend_timer_widget.dart';
import '../../../../core/widgets/text_field/otp_input_field.dart';
import '../../domain/entity/forget_password_params.dart';
import '../cubit/forget_password_cubit.dart';

class OtpStep extends StatelessWidget {
  const OtpStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();
    final otpController = TextEditingController();

    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
      listenWhen: (previous, current) =>
          previous.verifyOtpState != current.verifyOtpState,
      listener: (context, state) {
        if (state.verifyOtpState.state == BaseStateType.error) {
          CustomToast.showError(
            context: context,
            message:
                state.verifyOtpState.exception?.toString() ??
                AppStrings.invalidCode,
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.verifyOtpState != current.verifyOtpState,
      builder: (context, state) {
        if (state.verifyOtpState.isLoading) {
          return Center(
            child: CupertinoActivityIndicator(color: AppColors.primaryBlue),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              OtpInputField(
                controller: otpController,
                length: 6,
                hasError: state.verifyOtpState.state == BaseStateType.error,
                onCompleted: (otp) {
                  cubit.doIntent(VerifyOtpEvent(otp: otp));
                },
              ),
              if (state.verifyOtpState.state == BaseStateType.error) ...[
                const SizedBox(height: 8),
                const _ErrorMessage(),
              ],
              const SizedBox(height: 24),
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
          ),
        );
      },
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
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
