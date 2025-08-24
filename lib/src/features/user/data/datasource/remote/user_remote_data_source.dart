import 'package:attendance_app/src/core/api/api_client.dart';
import 'package:attendance_app/src/core/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> fetchUsers();
  Future<UserModel> changeAttendanceState(String userId, String newState);
  Future<void> updateUser(UserModel user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<UserModel>> fetchUsers() async {
    return await apiClient.getUsers();
  }

  @override
  Future<UserModel> changeAttendanceState(
    String userId,
    String newState,
  ) async {
    final user = await apiClient.changeAttendanceState(userId, {
      "attendance": newState,
    });
    return user;
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await apiClient.updateUser(user.id, user.toJson());
  }
}
