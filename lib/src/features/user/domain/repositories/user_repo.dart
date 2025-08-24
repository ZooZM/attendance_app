import 'package:attendance_app/src/core/errors/failures.dart';
import 'package:attendance_app/src/core/models/user_model.dart';
import 'package:attendance_app/src/features/user/domain/entities/user_fronted_detailes_model.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> fetchUsers();
  Future<Either<Failure, UserModel>> fetchUserById(String id);
  Future<Either<Failure, void>> changeAttendanceState(
    String userId,
    String newState,
  );
  Future<Either<Failure, void>> updateUser(UserModel user);
  Future<Either<Failure, void>> deleteUser(String userId);
}
