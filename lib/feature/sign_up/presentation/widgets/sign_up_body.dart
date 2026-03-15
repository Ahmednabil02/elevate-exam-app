import 'package:exam_app/config/helper/extensions/base_state/show_error_massage.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/text_field/email_field.dart';
import '../../../../core/widgets/text_field/phone_field.dart';
import '../../../../core/widgets/text_field/user_name_field.dart';
import '../../domain/models/sign_up_post_entity.dart';
import '../cubit/sign_up_cubit.dart';
import '../../../../core/widgets/login_link.dart';
import 'name_row.dart';
import 'password_row.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  late final SignUpCubit cubit;
  late final TextEditingController usernameController;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController rePasswordController;
  late final TextEditingController phoneController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    cubit = context.read<SignUpCubit>();
    usernameController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
    phoneController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    phoneController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      cubit.doIntent(
        SignUpUserEvent(
          params: SignUpPostEntity(
            username: usernameController.text.trim(),
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text,
            rePassword: rePasswordController.text,
            phone: phoneController.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _SingUpForm(
            usernameController: usernameController,
            firstNameController: firstNameController,
            lastNameController: lastNameController,
            emailController: emailController,
            passwordController: passwordController,
            rePasswordController: rePasswordController,
            phoneController: phoneController,
          ),
          const SizedBox(height: 48),
          _SubmitButton(onSubmit: _onSubmit),
          const SizedBox(height: 16),
           AuthLink(
            title:AppStrings.alreadyHaveAccount,
            actionTitle: AppStrings.login,
            action: () =>context.pop(),
          ),
        ],
      ),
    );
  }
}

class _SingUpForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController rePasswordController;
  final TextEditingController phoneController;

  const _SingUpForm({
    required this.usernameController,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.rePasswordController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      children: [
        UserNameField(controller: usernameController),
        NameRow(
          firstNameController: firstNameController,
          lastNameController: lastNameController,
        ),
        EmailField(controller: emailController),
        PasswordRow(
          passwordController: passwordController,
          rePasswordController: rePasswordController,
        ),
        PhoneField(
          controller: phoneController,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final void Function()? onSubmit;

  const _SubmitButton({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpStates>(
      listenWhen: (prev, curr) => prev.signUpState != curr.signUpState,
      listener: (context, state) {
        context.showErrorMessage(state.signUpState);
        if (state.signUpState.isSuccess) {
          context.go(Routes.home);
        }
      },
      buildWhen: (prev, curr) => prev.signUpState != curr.signUpState,
      builder: (context, state) {
        return CustomButton(
          text: AppStrings.signUp,
          isLoading: state.signUpState.isLoading,
          onPressed: onSubmit,
        );
      },
    );
  }
}
