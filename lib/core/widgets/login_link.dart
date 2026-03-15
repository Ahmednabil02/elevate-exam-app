import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../values/app_colors.dart';
import '../values/app_font_style.dart';

class AuthLink extends StatelessWidget {
  final String title;
  final String actionTitle;
  final void Function()? action;

  const AuthLink({super.key, required this.title, required this.actionTitle,required this.action});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: title,
        style: AppFontStyle.regular14(
          context,
        ).copyWith(color: AppColors.darkGray),
        children: [
          const TextSpan(text: ' '),
          TextSpan(
            text:actionTitle,
            style: AppFontStyle.semiBold14(context).copyWith(
              color: AppColors.primaryBlue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap =action,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
