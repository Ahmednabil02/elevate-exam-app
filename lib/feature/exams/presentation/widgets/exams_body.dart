import 'package:exam_app/config/helper/extensions/base_state/handle_builder_state.dart';
import 'package:exam_app/core/values/app_strings.dart';
import 'package:exam_app/feature/exams/presentation/cubit/exams_cubit.dart';
import 'package:exam_app/feature/exams/presentation/widgets/empty_exams_widget.dart';
import 'package:exam_app/feature/exams/presentation/widgets/exam_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamsBody extends StatelessWidget {
  const ExamsBody({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamsCubit, ExamsStates>(
      builder: (context, state) {
        return state.examsState.handleBuilderStateList(
          onSuccess:  ExamSection(exams: state.examsState.data,),
       onEmpty:  const EmptyExamsWidget(),
          onError: Center(child: Text(state.examsState.exception?.toString()?? AppStrings.somethingWentWrong)),


        )?? const SizedBox();
      },
    );
  }
}
