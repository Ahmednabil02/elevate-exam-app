import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/config/uses_cases/use_cases.dart';
import 'package:injectable/injectable.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

@injectable
class GetProfileUseCase extends UseCase<ProfileEntity, NoParams> {
  final ProfileRepository _repository;

  const GetProfileUseCase(this._repository);

  @override
  Future<Result<ProfileEntity>> call(NoParams params) async {
    return _repository.getProfileData();
  }
}
