import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_strings.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../cubit/forget_password_cubit.dart';
import '../widgets/forget_password_body.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ForgetPasswordCubit>(),
      child: const Scaffold(
        backgroundColor: AppColors.whiteF9,
        appBar: CustomAppBar(title: AppStrings.password),
        body: ForgetPasswordBody(),
      ),
    );
  }
}
