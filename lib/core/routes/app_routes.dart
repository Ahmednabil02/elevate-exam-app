import 'package:exam_app/config/api/end_points.dart';
import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exams/presentation/screen/exam_details_page.dart';
import 'package:exam_app/feature/exams/presentation/screen/exams_page.dart';
import 'package:exam_app/feature/forget_password/presentation/screen/forget_password_page.dart';
import 'package:exam_app/feature/home/presentation/screen/home_page.dart';
import 'package:exam_app/feature/login/presentation/cubit/login_cubit.dart';
import 'package:exam_app/feature/login/presentation/screen/login_page.dart';
import 'package:exam_app/feature/questions/presentation/screen/question_page.dart';
import 'package:exam_app/feature/sign_up/presentation/screen/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.login,
    routes: [
      GoRoute(
        path: Routes.login,
        name: Routes.login,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        path: Routes.home,
        name: Routes.home,
        builder: (BuildContext context, GoRouterState state) {
          return HomePage();
        },
      ),
      GoRoute(
        path: Routes.exams,
        name: Routes.exams,
        builder: (BuildContext context, GoRouterState state) {
          return ExamsPage();
        },
      ),
      GoRoute(
        path: Routes.examDetails,
        name: Routes.examDetails,
        builder: (BuildContext context, GoRouterState state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          final ExamEntity exam = extra['exam'];
          return ExamDetailsPage(exam: exam);
        },
      ),
      GoRoute(
        path: Routes.questions,
        name: Routes.questions,
        builder: (BuildContext context, GoRouterState state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          final ExamEntity exam = extra['exam'];
          return QuestionPage(exam: exam);
        },
      ),
      GoRoute(
        path: Routes.forgetPassword,
        name: Routes.forgetPassword,
        builder: (BuildContext context, GoRouterState state) {
          return ForgetPasswordPage();
        },
      ),
      GoRoute(
        path: Routes.register,
        name: Routes.register,
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpPage();
        },
      ),
    ],
    redirect: (context, state) async {
      final token = await getIt<FlutterSecureStorage>().read(
        key: APIkeys.accessToken,
      );
      final isLoggedIn = token != null && token.isNotEmpty;

      if (!isLoggedIn) return Routes.login;
      if (state.matchedLocation == Routes.login) return Routes.home;
      return null;
    },
  );
}
