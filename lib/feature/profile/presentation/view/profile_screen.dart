import 'dart:developer';

import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:exam_app/core/routes/routes.dart' show Routes;
import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/core/widgets/base_state_builder.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/core/widgets/email_field.dart';
import 'package:exam_app/core/widgets/password_field.dart';
import 'package:exam_app/core/widgets/text_field/phone_field.dart';
import 'package:exam_app/core/widgets/text_field/user_name_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _userNameController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  final TextEditingController _passwordController = TextEditingController(
    text: "123456",
  );
  late final TextEditingController _phoneController;
  late final ProfileCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<ProfileCubit>()..getProfile();
    _userNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _populateData(dynamic data) {
    // We only populate if the controllers are empty to avoid overwriting user edits
    // during background refreshes, though usually getProfile is only called once.
    if (_userNameController.text.isEmpty) {
      _userNameController.text = data.username ?? "";
      _firstNameController.text = data.firstName ?? "";
      _lastNameController.text = data.lastName ?? "";
      _emailController.text = data.email ?? "";
      _phoneController.text = data.phone ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.profile,
        showBackButton: false,
      ),
      body: BlocProvider<ProfileCubit>(
        create: (context) => cubit,
        child: Builder(
          builder: (context) {
            return BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state.profileState.isSuccess) {
                  log(
                    "Profile data loaded successfully: ${state.profileState.data}",
                  );
                  _populateData(state.profileState.data);
                }
                if (state.updateState.isSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Profile updated successfully"),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return BaseStateBuilder(
                  state: state.profileState,
                  onSuccess: (context, data) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 24.h,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            ProfileHeader(
                              imageUrl: data.image,
                              localImage: state.pickedImage,
                              onImageEdit: () =>
                                  context.read<ProfileCubit>().pickImage(),
                            ),
                            SizedBox(height: 32.h),
                            UserNameField(
                              controller: _userNameController,
                              enabled: true,
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _firstNameController,
                                    enabled: true,
                                    decoration: const InputDecoration(
                                      labelText: AppStrings.firstName,
                                      hintText: AppStrings.enterFirstName,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: TextFormField(
                                    controller: _lastNameController,
                                    enabled: true,
                                    decoration: const InputDecoration(
                                      labelText: AppStrings.lastName,
                                      hintText: AppStrings.enterLastName,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            EmailField(
                              controller: _emailController,
                              enabled: true,
                            ),
                            SizedBox(height: 16.h),
                            PasswordField(
                              controller: _passwordController,
                              enabled: true,
                              readOnly: true,
                              suffixIcon: TextButton(
                                onPressed: () =>
                                    context.push(Routes.changePassword),
                                child: const Text(
                                  "Change",
                                  style: TextStyle(
                                    color: AppColors.primaryBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            PhoneField(
                              controller: _phoneController,
                              enabled: true,
                            ),
                            SizedBox(height: 48.h),
                            CustomButton(
                              text: "Update",
                              isLoading: state.updateState.isLoading,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<ProfileCubit>().updateProfile(
                                    data.copyWith(
                                      username: _userNameController.text,
                                      firstName: _firstNameController.text,
                                      lastName: _lastNameController.text,
                                      email: _emailController.text,
                                      phone: _phoneController.text,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
