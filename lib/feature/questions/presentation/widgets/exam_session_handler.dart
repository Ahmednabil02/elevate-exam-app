import 'package:flutter/material.dart';
import 'package:exam_app/feature/questions/domain/entities/exam_session_entity.dart';
import 'package:exam_app/feature/questions/presentation/cubit/questions_cubit.dart';
import 'package:exam_app/feature/questions/presentation/cubit/questions_events.dart';
import 'package:exam_app/feature/questions/presentation/widgets/exam_session_dialog.dart';
import 'package:go_router/go_router.dart';

mixin ExamSessionHandler<T extends StatefulWidget> on State<T> {
  Future<void> initializeExam({
    required String examId,
    required int examDurationInMinutes,
    required QuestionsCubit cubit,
  }) async {
    await cubit.doIntent(
      CheckExamSessionEvent(
        examId: examId,
        examDurationInMinutes: examDurationInMinutes,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 100));

    final session = cubit.state.examSession;

    if (session == null) {
      await _startNewExam(examId, examDurationInMinutes, cubit);
    } else if (session.status == ExamSessionStatus.expired) {
      await _handleExpiredSession(
        examId,
        examDurationInMinutes,
        session,
        cubit,
      );
    } else if (session.status == ExamSessionStatus.inProgress) {
      await _handleInProgressSession(
        examId,
        examDurationInMinutes,
        session,
        cubit,
      );
    }
  }

  Future<void> _handleExpiredSession(
    String examId,
    int examDurationInMinutes,
    ExamSessionEntity session,
    QuestionsCubit cubit,
  ) async {
    if (!mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ExamSessionDialog.expired(
        onRestart: () =>
            _clearAndStartNew(examId, examDurationInMinutes, cubit),
        onCancel: _navigateBack,
      ),
    );
  }

  Future<void> _handleInProgressSession(
    String examId,
    int examDurationInMinutes,
    ExamSessionEntity session,
    QuestionsCubit cubit,
  ) async {
    if (!mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ExamSessionDialog.resume(
        onResume: () => cubit.doIntent(ResumeExamEvent(examId: examId)),
        onRestart: () =>
            _clearAndStartNew(examId, examDurationInMinutes, cubit),
      ),
    );
  }

  Future<void> _clearAndStartNew(
    String examId,
    int examDurationInMinutes,
    QuestionsCubit cubit,
  ) async {
    await cubit.doIntent(ClearExpiredExamEvent(examId: examId));
    await _startNewExam(examId, examDurationInMinutes, cubit);
  }

  Future<void> _startNewExam(
    String examId,
    int examDurationInMinutes,
    QuestionsCubit cubit,
  ) async {
    await cubit.doIntent(
      GetQuestionsEvent(
        examId: examId,
        examDurationInMinutes: examDurationInMinutes,
      ),
    );
  }

  void _navigateBack() {
    if (mounted) {
      context.pop();
    }
  }
}
