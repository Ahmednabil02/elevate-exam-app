import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/values/app_strings.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../cubit/forget_password_cubit.dart';
import '../widgets/forget_password_body.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late final ForgetPasswordCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<ForgetPasswordCubit>();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: const Scaffold(
        appBar: CustomAppBar(title: AppStrings.password),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
          child: ForgetPasswordBody(),
        ),
      ),
    );
  }
}
