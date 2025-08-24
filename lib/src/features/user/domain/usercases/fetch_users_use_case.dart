import 'package:attendance_app/src/core/errors/failures.dart';
import 'package:attendance_app/src/core/usecases/no_param_use_case.dart';
import 'package:attendance_app/src/features/user/domain/entities/user_fronted_detailes_model.dart';
import 'package:attendance_app/src/features/user/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';

class FetchUsersUseCase implements UseCase<List<UserEntity>> {
  final UserRepository userRepository;

  FetchUsersUseCase(this.userRepository);

  @override
  Future<Either<Failure, List<UserEntity>>> call() {
    return userRepository.fetchUsers();
  }
}
