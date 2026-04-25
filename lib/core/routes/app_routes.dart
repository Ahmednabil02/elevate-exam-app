import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:exam_app/features/profile/presentation/view/change_password_screen.dart';
import 'package:exam_app/features/profile/presentation/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.profile,
    routes: [
      GoRoute(
        path: Routes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const Scaffold(
            body: Center(
              child: Text('Core & Config Baseline Ready'),
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.profile,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => getIt<ProfileCubit>(),
            child: const ProfileScreen(),
          );
        },
      ),
      GoRoute(
        path: Routes.changePassword,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => getIt<ProfileCubit>(),
            child: const ChangePasswordScreen(),
          );
        },
      ),
    ],
  );
}
