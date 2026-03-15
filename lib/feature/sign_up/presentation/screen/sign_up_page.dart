import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:exam_app/feature/sign_up/presentation/widgets/sign_up_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/values/app_strings.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../cubit/sign_up_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignUpCubit>(),
      child: const Scaffold(
        appBar: CustomAppBar(title: AppStrings.signUp),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: SingleChildScrollView(child:SignUpBody()),
        ),
      ),
    );
  }
}
