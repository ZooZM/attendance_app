import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

abstract class UseCase<Type> {
  Future<Either<Failure, Type>> call();
}
