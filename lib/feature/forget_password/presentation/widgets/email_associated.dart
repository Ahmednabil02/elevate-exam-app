import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/base_state/state_types.dart';
import '../../../../core/validations/validations.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_font_style.dart';
import '../../../../core/values/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/text_field/email_field.dart';
import '../../domain/entity/forget_password_params.dart';
import '../cubit/forget_password_cubit.dart';

class EmailAssociated extends StatelessWidget {
  const EmailAssociated({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
      buildWhen: (previous, current) =>
          previous.sendOtpToEmailState != current.sendOtpToEmailState,
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              const _Title(),
              const SizedBox(height: 8),
              const _Subtitle(),
              const SizedBox(height: 32),
              EmailField(
                controller: emailController,
                validator: Validations.validateEmail,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: AppStrings.continueText,
                isLoading:
                    state.sendOtpToEmailState.state == BaseStateType.loading,
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    cubit.doIntent(
                      SendOtpToEmailEvent(
                        params: ForgetPasswordParams(
                          email: emailController.text,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
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
        AppStrings.forgetPassword,
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
        AppStrings.enterEmailAssociated,
        style: AppFontStyle.regular14(
          context,
        ).copyWith(color: AppColors.gray53),
        textAlign: TextAlign.center,
      ),
    );
  }
}
