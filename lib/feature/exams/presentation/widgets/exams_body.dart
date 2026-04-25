import 'package:exam_app/core/widgets/pagination_list_view.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exams/domain/entities/exams_parms.dart';
import 'package:exam_app/feature/exams/presentation/cubit/exams_cubit.dart';
import 'package:exam_app/feature/exams/presentation/widgets/empty_exams_widget.dart';
import 'package:exam_app/feature/exams/presentation/widgets/exam_card.dart';
import 'package:exam_app/feature/exams/presentation/widgets/exams_shimmer.dart';
import 'package:exam_app/feature/subject/domain/models/subject_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamsBody extends StatelessWidget {
  final SubjectEntity subjectEntity;
  const ExamsBody({super.key, required this.subjectEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamsCubit, ExamsStates>(
      buildWhen: (previous, current) =>
          previous.examsState != current.examsState,
      builder: (context, state) {
        return PaginationListView<ExamEntity>(
          state: state.examsState,
          emptyWidget: EmptyExamsWidget(),
          itemBuilder: (context, exam, index) =>
              ExamCard(exam: exam, subjectEntity: subjectEntity),
          onLoadMore: () {
            final examsCubit = context.read<ExamsCubit>();
            final examsState = examsCubit.state.examsState;
            final currentParams = examsState.query as ExamParms;
            final nextPage = examsState.currentPage + 1;
            examsCubit.doIntent(
              LoadMoreExamsEvent(
                params: currentParams.copyWith(page: nextPage),
              ),
            );
          },
          onRefresh: () async {
            final examsCubit = context.read<ExamsCubit>();
            examsCubit.doIntent(GetExamsEvent(subjectId: null));
          },
          loadingWidget: const ExamsShimmer(),
          loadingMoreWidget: const ExamCardShimmer(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        );
      },
    );
  }
}
