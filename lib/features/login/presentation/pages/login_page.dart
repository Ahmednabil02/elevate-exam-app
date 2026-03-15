import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/values/app_assets.dart';
import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/core/widgets/email_field.dart';
import 'package:exam_app/core/widgets/password_field.dart';
import 'package:exam_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:exam_app/features/login/presentation/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        leadingWidth: 150,
        leading: Row(
          children: [
            const SizedBox(width: 16),
            SvgPicture.asset(AppAssets.arrowBackIos, fit: BoxFit.scaleDown),
            const SizedBox(width: 8),
            Text(
              AppStrings.login,
              style: AppFontStyle.bold24(
                context,
              ).copyWith(color: AppColors.black),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  EmailField(
                    controller: _emailController,
                    onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  ),
                  const SizedBox(height: 35),
                  PasswordField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    toggleVisibility: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    onFieldSubmitted: (_) => _onLoginPressed(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: _rememberMe,
                              activeColor: AppColors.primaryBlue,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Remember me',
                            style: AppFontStyle.regular14(
                              context,
                            ).copyWith(color: AppColors.black),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          AppStrings.forgotPassword,
                          style: AppFontStyle.regular14(context).copyWith(
                            color: AppColors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login Successful')),
                          );
                          Navigator.pushReplacementNamed(context, Routes.home);
                        });
                      } else if (state is LoginError) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _passwordController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        });
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        text: AppStrings.login,
                        isLoading: state is LoginLoading,
                        onPressed: _onLoginPressed,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: AppFontStyle.regular17(
                                context,
                              ).copyWith(color: AppColors.black),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                AppStrings.signUp,
                                style: AppFontStyle.regular17(context).copyWith(
                                  color: AppColors.primaryBlue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(
        _emailController.text,
        _passwordController.text,
      );
    }
  }
}
