import 'package:attendance_app/src/core/errors/failures.dart';
import 'package:attendance_app/src/core/models/user_model.dart';
import 'package:attendance_app/src/core/usecases/use_case.dart';
import 'package:attendance_app/src/features/user/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';

class FetchSingleUserUseCase implements UseCase<UserModel, String> {
  final UserRepository userRepository;

  FetchSingleUserUseCase(this.userRepository);

  @override
  Future<Either<Failure, UserModel>> call(String userId) async {
    return await userRepository.fetchUserById(userId);
  }
}
