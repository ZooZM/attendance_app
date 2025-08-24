import 'package:attendance_app/src/core/api/api_client.dart';
import 'package:attendance_app/src/core/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> fetchUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<UserModel>> fetchUsers() async {
    return await apiClient.getUsers();
  }
}
