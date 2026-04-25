import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:exam_app/config/helper/extensions/base_state/show_error_massage.dart';
import 'package:exam_app/core/routes/app_routes.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/values/app_font_style.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/feature/main_layout/presentation/cubit/main_layout_cubit.dart';
import 'package:exam_app/feature/main_layout/presentation/cubit/main_layout_events.dart';
import 'package:exam_app/feature/main_layout/presentation/cubit/main_layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Logout extends StatefulWidget {
  const Logout({super.key});

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  late final MainLayoutCubit cubit;
  @override
  void initState() {
    cubit = getIt<MainLayoutCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.logOut),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider<MainLayoutCubit>(
          create: (context) => cubit,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              Text(
                AppStrings.logOutMessage,
                style: AppFontStyle.semiBold16(context),
                textAlign: TextAlign.center,
              ),
              BlocConsumer<MainLayoutCubit, MainLayoutStates>(
                listener: (context, state) {
                  if (state.logoutState.isError) {
                    context.showErrorMessage(state.logoutState);
                  }
                  if (state.logoutState.isSuccess) {
                    context.go(Routes.login);
                  }
                },
                buildWhen: (prev, state) =>
                    prev.logoutState != state.logoutState,
                builder: (context, state) {
                  return CustomButton(
                    text: AppStrings.logOut,
                    isEnabled: true,
                    backgroundColor: Colors.red,
                    isLoading: state.logoutState.isLoading,
                    onPressed: () {
                      cubit.doIndented(LogoutEvent());
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
