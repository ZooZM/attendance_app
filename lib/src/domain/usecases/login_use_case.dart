import 'package:attendance_app/src/core/errors/failures.dart';
import 'package:attendance_app/src/data/models/user_model.dart';
import 'package:attendance_app/src/core/usecases/use_case.dart';
import 'package:attendance_app/src/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements UseCase<UserModel, LoginParams> {
  final AuthRepo authRepo;

  LoginUseCase(this.authRepo);

  @override
  Future<Either<Failure, UserModel>> call(LoginParams params) async {
    return await authRepo.login(
      userNameOrEmail: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
