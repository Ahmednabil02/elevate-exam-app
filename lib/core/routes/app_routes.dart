import 'package:exam_app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:exam_app/feature/main_layout/main_screen.dart';
import 'package:exam_app/feature/subject/presentation/screen/subject_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.main,
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
        path: Routes.subjects,
        builder: (BuildContext context, GoRouterState state) {
          return const SubjectScreen();
        },
      ),
      GoRoute(
        path: Routes.main,
        builder: (BuildContext context, GoRouterState state) {
          return const MainScreen();
        },
      ),
    ],
  );
}
