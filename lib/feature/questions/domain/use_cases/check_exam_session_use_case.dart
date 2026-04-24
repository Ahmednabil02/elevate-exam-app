import 'package:exam_app/feature/questions/domain/entities/exam_session_entity.dart';
import 'package:exam_app/feature/questions/domain/repositories/questions_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CheckExamSessionUseCase {
  final QuestionsRepositoryContract _repository;

  CheckExamSessionUseCase({required QuestionsRepositoryContract repository})
    : _repository = repository;

  Future<ExamSessionEntity?> call({
    required String examId,
    required int examDurationInMinutes,
  }) async {
    return await _repository.checkExamSession(
      examId: examId,
      examDurationInMinutes: examDurationInMinutes,
    );
  }
}
