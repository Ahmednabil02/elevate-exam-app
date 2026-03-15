import 'dart:developer';

import 'package:exam_app/config/api/end_points.dart';
import 'package:exam_app/feature/sign_up/data/datasources/sign_up_local_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SignupLocalDataSourceContract)
class SignupLocalDataSourceImpl implements SignupLocalDataSourceContract {
  final FlutterSecureStorage fss;

  SignupLocalDataSourceImpl({required this.fss});

  @override
  Future<void> saveUserToken(String token) async {
    try {
      fss.write(key: Apikeys.accessToken, value: token);
    } catch (e) {
      log("the ex is :$e ");
    }
  }
}
