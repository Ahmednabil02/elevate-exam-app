import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/feature/exams/presentation/cubit/exams_cubit.dart';
import 'package:exam_app/feature/exams/presentation/widgets/exams_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamsPage extends StatefulWidget {
  const ExamsPage({super.key});

  @override
  State<ExamsPage> createState() => _ExamsPageState();
}

class _ExamsPageState extends State<ExamsPage> {
  late final ExamsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<ExamsCubit>()..doIntent(GetExamsEvent(subjectId: null));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Exams"),
      body: BlocProvider<ExamsCubit>.value(
        value: _cubit,
        child: SafeArea(child: ExamsBody()),
      ),
    );
  }
}
