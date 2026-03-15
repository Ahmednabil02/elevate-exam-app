
import 'package:exam_app/config/api/api_executer.dart';
import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/sign_up/api/api_client/sign_up_api_client.dart';
import 'package:exam_app/feature/sign_up/data/models/sign_up_post_model/sign_up_post_dto.dart';
import 'package:exam_app/feature/sign_up/data/models/sign_up_response/sign_up_response.dart';
import 'package:injectable/injectable.dart';

import '../../data/datasources/sign_up_remote_data_source.dart';

@Injectable(as: SignupRemoteDataSourceContract)
class SignUpRemoteDataSourceImpl implements SignupRemoteDataSourceContract {
  final SignUpApiClient homeApiClient;

  SignUpRemoteDataSourceImpl({required this.homeApiClient});

  @override
  Future<Result<SignUpResponse>> signUpUser(
    SignUpPostDto signupPostModel,
  ) async {
    return await executeApi<SignUpResponse>(() async {
      final response = await homeApiClient.signupUser(signupPostModel);
      return response;
    });
  }


}
