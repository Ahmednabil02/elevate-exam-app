import 'package:exam_app/feature/questions/domain/entities/questions_entity.dart';
import 'package:exam_app/feature/questions/domain/repositories/questions_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetSavedQuestionsUseCase {
  final QuestionsRepositoryContract _repository;

  GetSavedQuestionsUseCase({required QuestionsRepositoryContract repository})
    : _repository = repository;

  Future<List<QuestionEntity>?> call({required String examId}) async {
    return await _repository.getSavedQuestions(examId: examId);
  }
}
