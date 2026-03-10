import 'package:dartz/dartz.dart';
import '../../config/error_handling/failures.dart';

abstract class BaseUseCase<T, Parameters> {
  Future<Either<Failure, T>> call(Parameters parameters);
}

class NoParameters {
  const NoParameters();
}
