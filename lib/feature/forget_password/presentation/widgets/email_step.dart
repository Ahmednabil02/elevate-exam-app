import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/validations/validations.dart';
import '../../../../core/values/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_toast.dart';
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
              onFieldSubmitted: (_) {
                if (formKey.currentState?.validate() ?? false) {
                  cubit.doIntent(
                    SendOtpToEmailEvent(
                      params: ForgetPasswordParams(email: emailController.text),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 48),
            BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
              listenWhen: (previous, current) =>
                  previous.sendOtpToEmailState != current.sendOtpToEmailState,
              listener: (context, state) {
                if (state.sendOtpToEmailState.isError) {
                  CustomToast.showError(
                    context: context,
                    message:
                        state.sendOtpToEmailState.exception?.toString() ??
                        AppStrings.somethingWentWrong,
                  );
                }
              },
              buildWhen: (previous, current) =>
                  previous.sendOtpToEmailState != current.sendOtpToEmailState,
              builder: (context, state) {
                return CustomButton(
                  text: AppStrings.continueText,
                  isLoading: state.sendOtpToEmailState.isLoading,
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      log("Submitting email: ${emailController.text}");
                      cubit.doIntent(
                        SendOtpToEmailEvent(
                          params: ForgetPasswordParams(
                            email: emailController.text,
                          ),
                        ),
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
