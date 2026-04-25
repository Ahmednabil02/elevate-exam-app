import 'package:exam_app/config/api/end_points.dart';
import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/feature/answers/presentation/pages/answers_page.dart';
import 'package:exam_app/feature/answers/presentation/pages/exam_score_page.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exams/presentation/screen/exam_details_page.dart';
import 'package:exam_app/feature/exams/presentation/screen/exams_page.dart';
import 'package:exam_app/feature/forget_password/presentation/screen/forget_password_page.dart';
import 'package:exam_app/feature/login/presentation/cubit/login_cubit.dart';
import 'package:exam_app/feature/login/presentation/screen/login_page.dart';
import 'package:exam_app/feature/main_layout/main_screen.dart';
import 'package:exam_app/feature/questions/presentation/screen/question_page.dart';
import 'package:exam_app/feature/sign_up/presentation/screen/sign_up_page.dart';
import 'package:exam_app/feature/subject/domain/models/subject_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

abstract class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.main,
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
        path: Routes.main,
        name: Routes.main,
        builder: (BuildContext context, GoRouterState state) {
          return MainScreen();
        },
      ),
      GoRoute(
        path: Routes.exams,
        name: Routes.exams,
        builder: (BuildContext context, GoRouterState state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          final SubjectEntity subject = extra['subject'];
          return ExamsPage(subjectEntity: subject);
        },
      ),
      GoRoute(
        path: Routes.examDetails,
        name: Routes.examDetails,
        builder: (BuildContext context, GoRouterState state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          final ExamEntity exam = extra['exam'];
          final SubjectEntity subject = extra['subject'];
          return ExamDetailsPage(exam: exam, subject: subject);
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
        path: Routes.answersView,
        name: Routes.answersView,
        builder: (BuildContext context, GoRouterState state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          final String examId = extra['examId'];
          return AnswersPage(examId: examId);
        },
      ),
      GoRoute(
        path: Routes.examScore,
        name: Routes.examScore,
        builder: (BuildContext context, GoRouterState state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          final String examId = extra['examId'];
          return ExamScorePage(examId: examId);
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
      // GoRoute(
      //   path: Routes.profile,
      //   builder: (BuildContext context, GoRouterState state) {
      //     return BlocProvider(
      //       create: (context) => getIt<ProfileCubit>(),
      //       child: const EditProfileScreen(),
      //     );
      //   },
      // ),
      // GoRoute(
      //   path: Routes.changePassword,
      //   builder: (BuildContext context, GoRouterState state) {
      //     return BlocProvider(
      //       create: (context) => getIt<ProfileCubit>(),
      //       child: const ChangePasswordScreen(),
      //     );
      //   },
      // ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.matchedLocation}')),
    ),
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
