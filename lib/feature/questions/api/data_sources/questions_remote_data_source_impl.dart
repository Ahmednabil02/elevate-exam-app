import 'package:exam_app/config/api/api_execute.dart';
import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/questions/api/api_client/questions_api_client.dart';
import 'package:exam_app/feature/questions/data/dataـsources/questions_remote_data_source_contract.dart';
import 'package:exam_app/feature/questions/data/models/questions_response_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: QuestionsRemoteDataSourceContract)
class QuestionsRemoteDataSourceImpl
    implements QuestionsRemoteDataSourceContract {
  final QuestionsApiClient apiClient;

  QuestionsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Result<QuestionsResponseDto>> getQuestions(String examId) async {
    return await executeApi<QuestionsResponseDto>(
      () => apiClient.getQuestions(examId),
    );
  }
}
