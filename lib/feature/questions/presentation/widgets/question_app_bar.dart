import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/questions/presentation/cubit/questions_cubit.dart';
import 'package:exam_app/feature/questions/presentation/widgets/exam_timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ExamEntity exam;
  final VoidCallback onTimeEnd;

  const QuestionAppBar({
    super.key,
    required this.exam,
    required this.onTimeEnd,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: AppStrings.exam,
      actions: [_TimerAction(exam: exam, onTimeEnd: onTimeEnd)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TimerAction extends StatelessWidget {
  final ExamEntity exam;
  final VoidCallback onTimeEnd;

  const _TimerAction({required this.exam, required this.onTimeEnd});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      builder: (context, state) {
        if (state.examStartTime != null &&
            state.examDurationInMinutes != null) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ExamTimerWidget(
              startTime: state.examStartTime!,
              durationInMinutes: state.examDurationInMinutes!,
              onTimeExpired: onTimeEnd,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
