import 'package:exam_app/core/validations/validations.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/core/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Change password",
        showBackButton: true,
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.changePasswordState.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password changed successfully")),
            );
            context.pop();
          }
          if (state.changePasswordState.isError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Error: ${state.changePasswordState.exception.toString()}",
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  PasswordField(
                    controller: _currentPasswordController,
                    labelText: "Current password",
                    hintText: "Enter your current password",
                  ),
                  SizedBox(height: 16.h),
                  PasswordField(
                    controller: _newPasswordController,
                    labelText: "New password",
                    hintText: "Enter your new password",
                    validator: Validations.validatePassword,
                  ),
                  SizedBox(height: 16.h),
                  PasswordField(
                    controller: _confirmPasswordController,
                    labelText: "Confirm password",
                    hintText: "Enter your confirm password",
                    validator: (value) => Validations.validatePasswordVerification(
                      value,
                      _newPasswordController.text,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  CustomButton(
                    text: "Change",
                    isLoading: state.changePasswordState.isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ProfileCubit>().changePassword(
                          currentPassword: _currentPasswordController.text,
                          newPassword: _newPasswordController.text,
                          confirmPassword: _confirmPasswordController.text,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
