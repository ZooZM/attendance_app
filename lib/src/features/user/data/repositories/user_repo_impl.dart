import 'package:attendance_app/src/core/errors/failures.dart';
import 'package:attendance_app/src/features/user/data/datasource/local/user_local_data_source.dart';
import 'package:attendance_app/src/features/user/data/datasource/remote/user_remote_data_source.dart';
import 'package:attendance_app/src/features/user/domain/entities/user_fronted_detailes_model.dart';
import 'package:attendance_app/src/features/user/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, List<UserEntity>>> fetchUsers() async {
    try {
      final remoteUsers = await remoteDataSource.fetchUsers();
      localDataSource.cacheUsers(remoteUsers);
      List<UserEntity> userEntities = remoteUsers
          .map((user) => UserEntity.fromJson(user.toJson()))
          .toList();
      return Right(userEntities);
    } on Exception catch (e) {
      try {
        final localUsers = await localDataSource.fetchUsers();

        if (localUsers.isNotEmpty) {
          List<UserEntity> userEntities = localUsers
              .map((user) => UserEntity.fromJson(user.toJson()))
              .toList();
          return Right(userEntities);
        } else {
          return Left(
            ServerFailure('No cached users found, and server failed: $e'),
          );
        }
      } catch (localError) {
        return Left(
          ServerFailure(
            'Failed to fetch from both remote and local: $e | local error: $localError',
          ),
        );
      }
    }
  }
}
