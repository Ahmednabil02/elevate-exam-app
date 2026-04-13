import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/exams/data/models/exams_response_dto.dart';
import 'package:exam_app/feature/exams/domain/entities/exams_parms.dart';

abstract interface class ExamsRemoteDataSourceContract {
  Future<Result<ExamsResponseDto>> getExams({required ExamParms params});
}
