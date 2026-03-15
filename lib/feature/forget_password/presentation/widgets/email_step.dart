import 'package:exam_app/config/helper/extensions/base_state/show_error_massage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/validations/validations.dart';
import '../../../../core/values/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/text_field/email_field.dart';
import '../../domain/entity/forget_password_params.dart';
import '../cubit/forget_password_cubit.dart';

class EmailStep extends StatefulWidget {
  const EmailStep({super.key});

  @override
  State<EmailStep> createState() => _EmailStepState();
}

class _EmailStepState extends State<EmailStep> {
  late final ForgetPasswordCubit cubit;
  late final TextEditingController emailController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    cubit = context.read<ForgetPasswordCubit>();
    emailController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      cubit.doIntent(
        SendOtpToEmailEvent(
          params: ForgetPasswordParams(email: emailController.text.trim()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            EmailField(
              controller: emailController,
              validator: Validations.validateEmail,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _onSubmit(),
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
      listenWhen: (previous, current) =>
          previous.sendOtpToEmailState != current.sendOtpToEmailState,
      listener: (context, state) =>
          context.showErrorMessage(state.sendOtpToEmailState),
      buildWhen: (previous, current) =>
          previous.sendOtpToEmailState != current.sendOtpToEmailState,
      builder: (context, state) {
        return CustomButton(
          text: AppStrings.continueText,
          isLoading: state.sendOtpToEmailState.isLoading,
          onPressed: onSubmit,
        );
      },
    );
  }
}
