import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String forgotPassword = '/forgotPassword';
  static const String verifyCode = '/verifyCode';
  static const String resetPassword = '/resetPassword';
  static const String profile = '/profile';
  static const String exams = '/exams';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        builder: (BuildContext context, GoRouterState state) {
          return const Scaffold(
            body: Center(
              child: Text('Core & Config Baseline Ready'),
            ),
          );
        },
      ),
    ],
  );
}
