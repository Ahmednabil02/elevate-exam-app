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
    if (notification is! ScrollUpdateNotification) return false;

    final examsCubit = context.read<ExamsCubit>();
    final examsState = examsCubit.state.examsState;
    final threshold = notification.metrics.maxScrollExtent - 200;

    if (notification.metrics.pixels >= threshold &&
        examsState.canLoadMore &&
        !_isLoadingMore) {
      _loadMoreExams(examsCubit, examsState);
    }
    return false;
  }

  void _loadMoreExams(ExamsCubit cubit, dynamic examsState) {
    _isLoadingMore = true;
    final currentParams = examsState.query as ExamParms;
    final nextPage = examsState.currentPage + 1;

    cubit.doIntent(
      LoadMoreExamsEvent(params: currentParams.copyWith(page: nextPage)),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamsCubit, ExamsStates>(
      buildWhen: (previous, current) =>
          previous.examsState.data != current.examsState.data ||
          previous.examsState.state != current.examsState.state,
      builder: (context, state) => ExamsScrollView(
        state: state,
        onScrollNotification: _onScrollNotification,
      ),
    );
  }
}

class ExamsScrollView extends StatelessWidget {
  final ExamsStates state;
  final bool Function(ScrollNotification) onScrollNotification;

  const ExamsScrollView({
    super.key,
    required this.state,
    required this.onScrollNotification,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: onScrollNotification,
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
