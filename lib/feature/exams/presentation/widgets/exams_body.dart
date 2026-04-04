import 'package:exam_app/core/widgets/pagination_sliver_list.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exams/domain/entities/exams_parms.dart';
import 'package:exam_app/feature/exams/presentation/cubit/exams_cubit.dart';
import 'package:exam_app/feature/exams/presentation/widgets/exam_card.dart';
import 'package:exam_app/feature/exams/presentation/widgets/exams_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamsBody extends StatefulWidget {
  const ExamsBody({super.key});

  @override
  State<ExamsBody> createState() => ExamsBodyState();
}

class ExamsBodyState extends State<ExamsBody> {
  bool _isLoadingMore = false;

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final examsCubit = context.read<ExamsCubit>();
      final examsState = examsCubit.state.examsState;

      final maxScroll = notification.metrics.maxScrollExtent;
      final currentScroll = notification.metrics.pixels;
      final threshold = maxScroll - 200;

      if (currentScroll >= threshold &&
          examsState.canLoadMore &&
          !_isLoadingMore) {
        _isLoadingMore = true;

        final currentParams = examsState.query as ExamParms;
        final nextPage = examsState.currentPage + 1;

        examsCubit.doIntent(
          LoadMoreExamsEvent(params: currentParams.copyWith(page: nextPage)),
        );

        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) _isLoadingMore = false;
        });
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamsCubit, ExamsStates>(
      buildWhen: (previous, current) =>
          previous.examsState.data != current.examsState.data ||
          previous.examsState.state != current.examsState.state,
      builder: (context, state) => _buildScrollView(state),
    );
  }

  Widget _buildScrollView(ExamsStates state) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            sliver: PaginationSliverList<ExamEntity>(
              state: state.examsState,
              itemBuilder: (context, exam, index) => ExamCard(exam: exam),
              loadingWidget: const ExamsSliverShimmer(),
              loadingMoreWidget: const ExamCardShimmer(),
            ),
          ),
        ],
      ),
    );
  }
}
