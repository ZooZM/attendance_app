import 'package:attendance_app/src/core/errors/failures.dart';
import 'package:attendance_app/src/core/usecases/use_case.dart';
import 'package:attendance_app/src/data/models/user_model.dart';
import 'package:attendance_app/src/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class CreateAccountUseCase implements UseCase<UserModel, CreateAccountParams> {
  final AuthRepo authRepo;

  CreateAccountUseCase(this.authRepo);

  @override
  Future<Either<Failure, UserModel>> call(CreateAccountParams params) {
    return authRepo.createAccount(
      userName: params.userName,
      email: params.email,
      password: params.password,
      role: params.role,
      name: params.name,
    );
  }
}

class CreateAccountParams {
  final String userName;
  final String email;
  final String password;
  final String role;
  final String name;

  CreateAccountParams({
    required this.userName,
    required this.email,
    required this.password,
    required this.role,
    required this.name,
  });
}
