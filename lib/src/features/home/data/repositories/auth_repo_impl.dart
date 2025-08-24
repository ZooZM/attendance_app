import 'package:attendance_app/src/core/errors/failures.dart';
import 'package:attendance_app/src/features/home/data/datasources/local/local_data_source.dart';
import 'package:attendance_app/src/core/models/user_model.dart';
import 'package:attendance_app/src/features/home/data/datasources/remote/remote_data_source.dart';
import 'package:attendance_app/src/features/home/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepoImpl implements AuthRepo {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  AuthRepoImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, UserModel>> login({
    required String userNameOrEmail,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(userNameOrEmail, password);
      await localDataSource.storeUser(result);
      return Right(result);
    } catch (e) {
      try {
        final localUser = await localDataSource.getUserByUserNameOrEmail(
          userNameOrEmail,
          userNameOrEmail.contains('@'),
        );
        final existingUsersLocal = await localDataSource
            .getUserByUserNameOrEmail(userNameOrEmail, false);

        final existingUsersLocalByEmail = await localDataSource
            .getUserByUserNameOrEmail(userNameOrEmail, true);
        if (existingUsersLocal == null && existingUsersLocalByEmail == null) {
          return Left(ServerFailure("User not Found."));
        }
        if (localUser!.password == password) {
          if (localUser.role == 'admin') {
            return Right(localUser);
          } else {
            return Left(ServerFailure("You are not authorized to login."));
          }
        } else {
          return Left(ServerFailure("Invalid credentials"));
        }
      } catch (_) {
        if (e is DioException) {
          return Left(ServerFailure(e.message ?? 'Server error'));
        }
        return Left(ServerFailure('Unexpected error'));
      }
    }
  }

  @override
  Future<Either<Failure, UserModel>> createAccount({
    required String userName,
    required String email,
    required String password,
    required String role,
    required String name,
  }) async {
    try {
      final result = await remoteDataSource.createAccount(
        userName,
        email,
        password,
      );
      await localDataSource.storeUser(result);

      return Right(result);
    } catch (e) {
      final existingUsersLocal = await localDataSource.getUserByUserNameOrEmail(
        userName,
        false,
      );

      final existingUsersLocalByEmail = await localDataSource
          .getUserByUserNameOrEmail(email, true);
      if (existingUsersLocal != null || existingUsersLocalByEmail != null) {
        return Left(ServerFailure("User already exists locally."));
      }
      final localUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        role: role,
        userName: userName,
        attendance: [],
        createdAt: DateTime.now(),
        password: password,
      );

      await localDataSource.storeUser(localUser);
      return Right(localUser);
    }
  }
}
