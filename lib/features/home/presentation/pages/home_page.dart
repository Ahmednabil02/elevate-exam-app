import 'package:flutter/material.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_font_style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Welcome to Elevate Exam App!',
          style: AppFontStyle.bold24(context).copyWith(color: AppColors.primaryBlue),
        ),
      ),
    );
  }
}
