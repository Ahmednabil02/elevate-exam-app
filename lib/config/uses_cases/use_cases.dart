import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:exam_app/config/error_handling/failures.dart';


abstract class UseCase<T, Params> {
  Future<Either<Failures, T>> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
