import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/feature/questions/domain/entities/questions_entity.dart';
import 'package:exam_app/feature/questions/presentation/cubit/questions_cubit.dart';
import 'package:exam_app/feature/questions/presentation/cubit/questions_events.dart';
import 'package:exam_app/feature/questions/presentation/widgets/question_card.dart';
import 'package:exam_app/feature/questions/presentation/widgets/question_navigation_buttons.dart';
import 'package:exam_app/feature/questions/presentation/widgets/question_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class QuestionsContent extends StatefulWidget {
  const QuestionsContent({
    super.key,

    required this.questions,
    required this.currentPage,
    required this.examId,
  });

  final List<QuestionEntity> questions;
  final int currentPage;
  final String examId;

  @override
  State<QuestionsContent> createState() => _QuestionsContentState();
}

class _QuestionsContentState extends State<QuestionsContent> {
  late final QuestionsCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<QuestionsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[widget.currentPage];
    final isLastQuestion = widget.currentPage >= widget.questions.length - 1;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            QuestionStepper(
              totalQuestions: widget.questions.length,
              currentQuestion: widget.currentPage + 1,
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: SingleChildScrollView(
                child: QuestionCard(
                  question: currentQuestion,
                  onAnswerSelected: (answer) => _cubit.doIntent(
                    AnswerSelectedEvent(
                      index: widget.currentPage,
                      selectAnswer: answer,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            QuestionNavigationButtons(
              currentPage: widget.currentPage,
              nextButtonText: isLastQuestion
                  ? AppStrings.submit
                  : AppStrings.next,
              onBack: () => _cubit.doIntent(
                QuestionChanged(currentPage: widget.currentPage - 1),
              ),
              onNext: () => isLastQuestion
                  ? _onSubmit(context)
                  : _cubit.doIntent(
                      QuestionChanged(currentPage: widget.currentPage + 1),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit(BuildContext context) {
    final cubit = context.read<QuestionsCubit>();
    cubit.doIntent(SubmitExamEvent(examId: widget.examId));
    context.pushReplacement(Routes.examScore, extra: {"examId": widget.examId});
  }
}
