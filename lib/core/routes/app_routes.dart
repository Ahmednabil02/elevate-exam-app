import 'package:exam_app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    ],
  );
}
