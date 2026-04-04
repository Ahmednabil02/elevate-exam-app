import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/feature/exams/presentation/cubit/exams_cubit.dart';
import 'package:exam_app/feature/exams/presentation/widgets/exams_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamsPage extends StatelessWidget {
  const ExamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Exams"),
      body: BlocProvider<ExamsCubit>(
        create: (context) =>
            getIt<ExamsCubit>()..doIntent(GetExamsEvent(subjectId: null)),
        child: SafeArea(child: ExamsBody()),
      ),
    );
  }
}
