import 'package:exam_app/core/values/app_colors.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
      buildWhen: (previous, current) =>
          previous.currentScreen != current.currentScreen,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
          child: Column(
            children: [
              _Title(titles[state.currentScreen]),
              _Subtitle(subTitles[state.currentScreen]),
              SizedBox(height: 32),
              Expanded(
                child: IndexedStack(
                  index: state.currentScreen,
                  children: const [EmailStep(), OtpStep(), ResetPasswordStep()],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppFontStyle.semiBold18(context).copyWith(color: AppColors.black),
      textAlign: TextAlign.center,
    );
  }
}

class _Subtitle extends StatelessWidget {
  final String subtitle;

  const _Subtitle(this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: AppFontStyle.regular14(
        context,
      ).copyWith(color: AppColors.darkGray),
      textAlign: TextAlign.center,
    );
  }
}
