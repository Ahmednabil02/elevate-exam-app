import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/feature/questions/domain/entities/questions_entity.dart';
import 'package:exam_app/feature/questions/domain/repositories/questions_repository.dart'
    show QuestionsRepositoryContract;
import 'package:injectable/injectable.dart';

@Injectable()
class GetQuestionsUseCase {
  final QuestionsRepositoryContract repo;

  GetQuestionsUseCase({required this.repo});
  Future<Result<List<QuestionEntity>>> call(String examId) =>
      repo.getQuestions(examId);
}
