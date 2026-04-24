import 'package:exam_app/feature/questions/domain/repositories/questions_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SaveExamEndTimeUseCase {
  final QuestionsRepositoryContract _repository;

  SaveExamEndTimeUseCase({required QuestionsRepositoryContract repository})
    : _repository = repository;

  Future<void> call({required String examId, required DateTime endTime}) async {
    return await _repository.saveExamEndTime(examId: examId, endTime: endTime);
  }
}
