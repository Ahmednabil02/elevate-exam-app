import 'package:exam_app/config/api/end_points.dart';
import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/values/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final token = await getIt<FlutterSecureStorage>().read(
      key: APIkeys.accessToken,
    );

    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) return;
    FlutterNativeSplash.remove();
    if (token != null && token.isNotEmpty) {
      context.go(Routes.main);
    } else {
      context.go(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          AppAssets.elevateLogo,
          width: 200.w,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
