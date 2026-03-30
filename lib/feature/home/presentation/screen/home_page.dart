import 'dart:developer';

import 'package:exam_app/config/api/end_points.dart';
import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:exam_app/core/routes/app_routes.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: CustomButton(
            text:
            'Go to exam',
            onPressed: ()  {
             context.push(Routes.exams);
            },
          ),

        ),
      ),
    );
  }
}
