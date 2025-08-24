import 'package:attendance_app/src/core/errors/failures.dart';
import 'package:attendance_app/src/core/models/user_model.dart';
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
              .map(
                (user) => user.role != 'admin'
                    ? UserEntity.fromJson(user.toJson())
                    : null,
              )
              .whereType<UserEntity>()
              .toList();
          return Right(userEntities);
        } else {
          return Left(
            ServerFailure('No cached users found, and server failed.'),
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

  @override
  Future<Either<Failure, void>> changeAttendanceState(
    String userId,
    String newState,
  ) async {
    try {
      UserModel user = await remoteDataSource.changeAttendanceState(
        userId,
        newState,
      );
      await localDataSource.updateUser(user);
      return const Right(null);
    } catch (e) {
      try {
        UserModel? user = await localDataSource.getUserById(userId);
        if (user != null) {
          await localDataSource.updateUser(
            UserModel(
              password: user.password,
              createdAt: user.createdAt,
              id: user.id,
              name: user.name,
              email: user.email,
              role: user.role,
              userName: user.userName,
              attendance: newState,
            ),
          );
        }
      } catch (e) {
        return Left(ServerFailure('Failed to update local user: $e'));
      }
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(UserModel user) async {
    try {
      await remoteDataSource.updateUser(user);
      await localDataSource.updateUser(user);
      return const Right(null);
    } catch (e) {
      try {
        final existingUsersLocal = await localDataSource
            .getUserByUserNameOrEmail(user.userName, false);

        final existingUsersLocalByEmail = await localDataSource
            .getUserByUserNameOrEmail(user.email, true);
        if (existingUsersLocal != null || existingUsersLocalByEmail != null) {
          if (existingUsersLocalByEmail!.id == user.id) {
            await localDataSource.updateUser(user);
            return const Right(null);
          }
          return Left(
            ServerFailure("this Email or userName already exists locally."),
          );
        }
      } catch (e) {
        return Left(ServerFailure('Failed to update local user: $e'));
      }
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, UserModel>> fetchUserById(String id) async {
    try {
      final user = await remoteDataSource.fetchUserById(id);
      return Right(user);
    } catch (e) {
      try {
        final localUser = await localDataSource.getUserById(id);
        if (localUser != null) {
          return Right(localUser);
        } else {
          return Left(ServerFailure('No cached user found with id: $id'));
        }
      } catch (localError) {
        return Left(
          ServerFailure(
            'Failed to fetch user from both remote and local: $e | local error: $localError',
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String userId) async {
    try {
      await localDataSource.deleteUser(userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to delete user: $e'));
    }
  }
}
