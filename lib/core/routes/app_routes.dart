import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/feature/home/presentation/screen/home_page.dart';
import 'package:exam_app/feature/login/presentation/cubit/login_cubit.dart';
import 'package:exam_app/feature/login/presentation/screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.login,
    routes: [
      GoRoute(
        path: Routes.login,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        path: Routes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
    ],
  );
}
