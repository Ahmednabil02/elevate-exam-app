import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/feature/answers/presentation/cubit/answers_cubit.dart';
import 'package:exam_app/feature/answers/presentation/cubit/answers_events.dart';
import 'package:exam_app/feature/answers/presentation/widgets/answers_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnswersPage extends StatefulWidget {
  const AnswersPage({super.key, required this.examId});

  final String examId;

  @override
  State<AnswersPage> createState() => _AnswersPageState();
}

class _AnswersPageState extends State<AnswersPage> {
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
        appBar: CustomAppBar(title: AppStrings.answers),
        body: const AnswersBody(),
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
