import 'package:attendance_app/src/core/errors/failures.dart';
import 'package:attendance_app/src/core/usecases/use_case.dart';
import 'package:attendance_app/src/features/user/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';

class DeleteUserUseCase implements UseCase<void, String> {
  final UserRepository userRepository;

  DeleteUserUseCase(this.userRepository);

  @override
  Future<Either<Failure, void>> call(String userId) async {
    return await userRepository.deleteUser(userId);
  }
}
