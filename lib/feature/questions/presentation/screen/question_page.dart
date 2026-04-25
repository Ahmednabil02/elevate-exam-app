import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/questions/presentation/cubit/questions_cubit.dart';
import 'package:exam_app/feature/questions/presentation/widgets/exam_session_handler.dart';
import 'package:exam_app/feature/questions/presentation/widgets/question_app_bar.dart';
import 'package:exam_app/feature/questions/presentation/widgets/questions_body.dart';
import 'package:exam_app/feature/questions/presentation/widgets/time_out_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionPage extends StatefulWidget {
  final ExamEntity exam;

  const QuestionPage({super.key, required this.exam});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> with ExamSessionHandler {
  late final QuestionsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<QuestionsCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeExam(
        examId: widget.exam.id,
        examDurationInMinutes: widget.exam.duration ?? 30,
        cubit: _cubit,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuestionsCubit>(
      create: (context) => _cubit,
      child: Scaffold(
        appBar: QuestionAppBar(exam: widget.exam, onTimeEnd: _handleTimeEnd),
        body: QuestionsBody(examEntity: widget.exam),
      ),
    );
  }

  void _handleTimeEnd() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => TimeOutDialog(examEntity: widget.exam),
    );
  }
}
