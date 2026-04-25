import 'package:exam_app/config/base_response/result.dart';
import 'package:exam_app/config/uses_cases/use_cases.dart';
import 'package:injectable/injectable.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

@injectable
class UpdateProfileUseCase extends UseCase<ProfileEntity, ProfileEntity> {
  final ProfileRepository _repository;

  const UpdateProfileUseCase(this._repository);

  @override
  Future<Result<ProfileEntity>> call(ProfileEntity params) async {
    return _repository.updateProfile(params);
  }
}
