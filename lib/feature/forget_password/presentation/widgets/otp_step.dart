import 'package:exam_app/config/helper/extensions/base_state/handle_builder_state.dart';
import 'package:exam_app/config/helper/extensions/base_state/show_error_massage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/resend_timer_widget.dart';
import '../../../../core/widgets/text_field/otp_input_field.dart';
import '../../domain/entity/forget_password_params.dart';
import '../cubit/forget_password_cubit.dart';

class OtpStep extends StatefulWidget {
  const OtpStep({super.key});

  @override
  State<OtpStep> createState() => _OtpStepState();
}

class _OtpStepState extends State<OtpStep> {
  late final TextEditingController otpController;

  @override
  void initState() {
    otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
      listenWhen: (previous, current) =>
          previous.verifyOtpState != current.verifyOtpState,
      listener: (context, state) =>
          context.showErrorMessage(state.verifyOtpState),
      buildWhen: (previous, current) =>
          previous.verifyOtpState != current.verifyOtpState,
      builder: (context, state) {
        return state.verifyOtpState.handleBuilderState() ??
            _OtpBody(
              otpController: otpController,
              email: state.email??'',
              isError: state.verifyOtpState.isError,
            );
      },
    );
  }
}

class _OtpBody extends StatelessWidget {
  final TextEditingController otpController;
  final String email;
  final bool isError;

  const _OtpBody({
    required this.otpController,
    required this.email,
    required this.isError,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _OtpField(otpController: otpController, isError: isError),
          const SizedBox(height: 24),
          ResendTimerWidget(
            onResend: () => context.read<ForgetPasswordCubit>().doIntent(
              SendOtpToEmailEvent(params: ForgetPasswordParams(email: email)),
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpField extends StatelessWidget {
  final TextEditingController otpController;
  final bool isError;

  const _OtpField({required this.otpController, required this.isError});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        OtpInputField(
          controller: otpController,
          length: 6,
          hasError: isError,
          onCompleted: (otp) => context.read<ForgetPasswordCubit>().doIntent(
            VerifyOtpEvent(otp: otp),
          ),
        ),
        if (isError) const ErrorMessage(),
      ],
    );
  }
}
