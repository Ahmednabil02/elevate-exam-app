import 'package:flutter/material.dart';

import '../values/app_colors.dart';

enum QuestionOptionState { normal, selected, correct, incorrect }

class QuestionOptionCard extends StatelessWidget {
  final String text;
  final QuestionOptionState state;
  final VoidCallback onTap;

  const QuestionOptionCard({
    super.key,
    required this.text,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color getBackgroundColor() {
      switch (state) {
        case QuestionOptionState.selected:
          return AppColors.blue40;
        case QuestionOptionState.correct:
          return AppColors.lightGreen;
        case QuestionOptionState.incorrect:
          return AppColors.redD2;
        case QuestionOptionState.normal:
          return AppColors.white;
      }
    }

    Color getBorderColor() {
      switch (state) {
        case QuestionOptionState.selected:
          return AppColors.primaryBlue;
        case QuestionOptionState.correct:
          return AppColors.green19;
        case QuestionOptionState.incorrect:
          return AppColors.red;
        case QuestionOptionState.normal:
          return Colors.grey.shade300;
      }
    }

    IconData getIcon() {
      switch (state) {
        case QuestionOptionState.selected:
          return Icons.radio_button_checked;
        case QuestionOptionState.correct:
          return Icons.check_circle;
        case QuestionOptionState.incorrect:
          return Icons.cancel;
        case QuestionOptionState.normal:
          return Icons.radio_button_unchecked;
      }
    }

    Color getIconColor() {
      switch (state) {
        case QuestionOptionState.selected:
          return AppColors.primaryBlue;
        case QuestionOptionState.correct:
          return AppColors.green19;
        case QuestionOptionState.incorrect:
          return AppColors.red;
        case QuestionOptionState.normal:
          return AppColors.gray53;
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: getBackgroundColor(),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: getBorderColor(), width: 1.5),
        ),
        child: Row(
          children: [
            Icon(getIcon(), color: getIconColor(), size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
