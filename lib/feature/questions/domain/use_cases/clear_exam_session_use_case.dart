import 'package:exam_app/feature/questions/domain/repositories/questions_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ClearExamSessionUseCase {
  final QuestionsRepositoryContract _repository;

  ClearExamSessionUseCase({required QuestionsRepositoryContract repository})
    : _repository = repository;
  Future<void> call({required String examId}) async {
    await _repository.clearSavedQuestions(examId: examId);
  }
}
