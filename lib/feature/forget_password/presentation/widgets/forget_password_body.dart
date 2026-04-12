import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/forget_password_cubit.dart';
import 'email_step.dart';
import 'otp_step.dart';
import 'reset_password_step.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({super.key});

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  late final List<String> titles;
  late final List<String> subTitles;

  @override
  void initState() {
    super.initState();
    titles = [
      AppStrings.forgetPassword,
      AppStrings.emailVerification,
      AppStrings.resetPassword,
    ];
    subTitles = [
      AppStrings.enterEmailAssociated,
      AppStrings.enterCodeSentToEmail,
      AppStrings.passwordMustContain,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
      buildWhen: (previous, current) =>
          previous.currentScreen != current.currentScreen,
      builder: (context, state) {
        return Column(
          children: [
            _StepHeader(
              title: titles[state.currentScreen],
              subtitle: subTitles[state.currentScreen],
            ),
            const SizedBox(height: 32),
            Expanded(
              child: IndexedStack(
                index: state.currentScreen,
                children: const [
                  EmailInputScreen(),
                  OtpVerificationScreen(),
                  NewPasswordScreen(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StepHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _StepHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      children: [
        Text(
          title,
          style: AppFontStyle.semiBold18(
            context,
          ).copyWith(color: textTheme.titleLarge?.color),
          textAlign: TextAlign.center,
        ),
        Text(
          subtitle,
          style: AppFontStyle.regular14(
            context,
          ).copyWith(color: textTheme.bodyMedium?.color?.withOpacity(0.6)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
