import 'package:exam_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/exams/data/datasources/exams_remote_data_source_contract.dart';
import 'package:exam_app/feature/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exams/domain/entities/exams_parms.dart';
import 'package:exam_app/feature/exams/domain/repositories/exams_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ExamsRepository)
class ExamsRepositoryImpl implements ExamsRepository {
  final ExamsRemoteDataSourceContract examsRemoteDataSourceContract;

  ExamsRepositoryImpl({required this.examsRemoteDataSourceContract});

  @override
  Future<Result<BasePaginationEntity<ExamEntity>>> getExams({
    required ExamParms params,
  }) async {
    final result = await examsRemoteDataSourceContract.getExams(params: params);
    return result.when(
      success: (data) => Success(data: data?.toEntity()),
      error: (exception) => Error(exception: exception),
    );
  }
}
