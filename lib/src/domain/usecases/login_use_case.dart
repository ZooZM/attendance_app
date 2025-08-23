import 'package:attendance_app/src/core/errors/failures.dart';
import 'package:attendance_app/src/data/models/user_model.dart';
import 'package:attendance_app/src/core/usecases/use_case.dart';
import 'package:attendance_app/src/data/repositories/auth_repo_impl.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements UseCase<UserModel, LoginParams> {
  final AuthRepoImpl authRepoImpl;

  LoginUseCase(this.authRepoImpl);

  @override
  Future<Either<Failure, UserModel>> call(LoginParams params) async {
    return await authRepoImpl.login(
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
