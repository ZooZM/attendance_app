import 'package:attendance_app/src/core/errors/failures.dart';
import 'package:attendance_app/src/data/models/user_model.dart';
import 'package:attendance_app/src/data/datasources/remote/remote_data_sorce.dart';
import 'package:attendance_app/src/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepoImpl implements AuthRepo {
  final RemoteDataSource remoteDataSource;

  AuthRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserModel>> login({
    required String userNameOrEmail,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(userNameOrEmail, password);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure(e.message ?? 'Server error'));
      }
      return Left(ServerFailure('Unexpected error'));
    }
  }
}
