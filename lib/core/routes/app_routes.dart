import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/feature/forget_password/presentation/screen/forget_password_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../feature/sign_up/presentation/screen/sign_up_page.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.home,
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
        path: Routes.forgetPassword,
        builder: (BuildContext context, GoRouterState state) {
          return ForgetPasswordPage();
        },
      ),
    ],
  );
}
