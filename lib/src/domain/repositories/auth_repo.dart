import 'package:attendance_app/src/core/errors/failures.dart';
import 'package:attendance_app/src/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> login({
    required String userNameOrEmail,
    required String password,
  });
  Future<Either<Failure, UserModel>> createAccount({
    required String userName,
    required String email,
    required String password,
    required String role,
    required String name,
  });
}
