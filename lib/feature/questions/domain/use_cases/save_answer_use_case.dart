import 'package:exam_app/feature/questions/domain/entities/questions_entity.dart';
import 'package:exam_app/feature/questions/domain/repositories/questions_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SaveAnswerUseCase {
  final QuestionsRepositoryContract _repository;

  SaveAnswerUseCase({required QuestionsRepositoryContract repository})
    : _repository = repository;
  Future<void> call({
    required String examId,
    required QuestionEntity question,
  }) async {
    await _repository.saveQuestionAnswer(examId: examId, question: question);
  }
}
