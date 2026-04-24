import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/feature/answers/presentation/cubit/answers_cubit.dart';
import 'package:exam_app/feature/answers/presentation/cubit/answers_events.dart';
import 'package:exam_app/feature/answers/presentation/pages/answers_page.dart';
import 'package:exam_app/feature/answers/presentation/widgets/exam_score_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ExamScorePage extends StatefulWidget {
  const ExamScorePage({super.key, required this.examId});

  final String examId;

  @override
  State<ExamScorePage> createState() => _ExamScorePageState();
}

class _ExamScorePageState extends State<ExamScorePage> {
  late final AnswersCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<AnswersCubit>();
    _cubit.doIntent(LoadAnswersEvent(examId: widget.examId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnswersCubit>(
      create: (context) => _cubit,
      child: Scaffold(
        backgroundColor: AppColors.whiteF9,
        appBar: CustomAppBar(
          title: AppStrings.examScore,
          backgroundColor: AppColors.whiteF9,
        ),
        body: ExamScoreBody(
          onShowResults: _navigateToAnswers,
          onStartAgain: _navigateBack,
        ),
      ),
    );
  }

  void _navigateToAnswers() {
    context.push(Routes.answersView, extra: {"examId": widget.examId});
  }

  void _navigateBack() {
    context.pop();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
