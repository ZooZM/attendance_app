import 'package:attendance_app/src/core/errors/failures.dart';
import 'package:attendance_app/src/core/models/user_model.dart';
import 'package:attendance_app/src/core/usecases/use_case.dart';
import 'package:attendance_app/src/features/user/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateUserUseCase implements UseCase<void, UserModel> {
  final UserRepository userRepository;

  UpdateUserUseCase(this.userRepository);

  @override
  Future<Either<Failure, void>> call(UserModel user) async {
    return await userRepository.updateUser(user);
  }
}
