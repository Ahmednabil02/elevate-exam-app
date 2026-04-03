import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exams/domain/entities/exams_parms.dart';
import 'package:exam_app/feature/exams/presentation/cubit/exams_cubit.dart';
import 'package:exam_app/feature/exams/presentation/widgets/exam_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamSection extends StatefulWidget {
  const ExamSection({super.key, required this.exams,});

  final List<ExamEntity> exams;

  @override
  State<ExamSection> createState() => _ExamSectionState();
}

class _ExamSectionState extends State<ExamSection> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        context.read<ExamsCubit>().doIntent(
          LoadMoreExamsEvent(
            params: ExamParms(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: widget.exams.length,
      itemBuilder: (context, index) =>
          ExamRow(exam: widget.exams[index],),
    );
  }
}
