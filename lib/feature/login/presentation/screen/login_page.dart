import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/core/widgets/email_field.dart';
import 'package:exam_app/core/widgets/password_field.dart';
import 'package:go_router/go_router.dart';
import '../cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().doIntent(
            LoginButtonEvent(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(),
      body: BlocConsumer<LoginCubit, LoginStates>(
        listener: _onStateChanged,
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  _buildLoginForm(state),
                  const SizedBox(height: 16),
                  _buildForgetPassword(),
                  const SizedBox(height: 40),
                  _buildLoginButton(state),
                  const SizedBox(height: 24),
                  _buildSignupLink(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() => AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              const Icon(Icons.arrow_back_ios, color: AppColors.black, size: 20),
              const SizedBox(width: 4),
              Text(
                "Login",
                style: AppFontStyle.medium20(context).copyWith(color: AppColors.black),
              ),
            ],
          ),
        ),
      );

  Widget _buildLoginForm(LoginStates state) => Column(
        children: [
          EmailField(
            controller: _emailController,
            labelText: "Email",
            hintText: "Enter your email",
          ),
          const SizedBox(height: 24),
          PasswordField(
            controller: _passwordController,
            labelText: "Password",
            hintText: "Enter your password",
            obscureText: !state.passwordVisible,
            toggleVisibility: () {
              context.read<LoginCubit>().doIntent(
                    const TogglePasswordVisibilityEvent(),
                  );
            },
          ),
        ],
      );

  Widget _buildForgetPassword() => Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            context.push(Routes.forgetPassword);
          },
          child: Text(
            "Forget password",
            style: AppFontStyle.regular16(context).copyWith(
              color: AppColors.black,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );

  Widget _buildLoginButton(LoginStates state) => CustomButton(
        text: "Login",
        isLoading: state.loginState.isLoading,
        onPressed: _onLoginPressed,
      );

  Widget _buildSignupLink() => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: AppFontStyle.regular16(context).copyWith(color: AppColors.black),
            ),
            TextButton(
              onPressed: () {
                context.push(Routes.register);
              },
              child: Text(
                "Sign up",
                style: AppFontStyle.medium16(context).copyWith(
                  color: AppColors.primaryBlue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      );

  void _onStateChanged(BuildContext context, LoginStates state) {
    state.loginState.when(
      initial: () {},
      loading: () {},
      success: (data) {
        context.pushReplacementNamed(Routes.home);
      },
      error: (exception) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(exception.toString())),
        );
      },
    );
  }
}
