import 'package:exam_app/config/api/api_execute.dart';
import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/exams/api/api_client/exams_api_client.dart';
import 'package:exam_app/feature/exams/data/dataـsources/exams_remote_data_source_contract.dart';
import 'package:exam_app/feature/exams/data/models/exams_response_dto.dart';
import 'package:exam_app/feature/exams/domain/entities/exams_parms.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExamsRemoteDataSourceContract)
class ExamsRemoteDataSourceImpl implements ExamsRemoteDataSourceContract {
  final ExamsApiClient apiClient;

  ExamsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Result<ExamsResponseDto>> getExams({required ExamParms params}) async {
    return await executeApi<ExamsResponseDto>(() => apiClient.getExams(params));
  }
}
