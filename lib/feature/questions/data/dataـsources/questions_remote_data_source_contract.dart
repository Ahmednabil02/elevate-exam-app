import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/questions/data/models/questions_response_dto.dart';

abstract interface class QuestionsRemoteDataSourceContract {
  Future<Result<QuestionsResponseDto>> getQuestions(String examId);
}
