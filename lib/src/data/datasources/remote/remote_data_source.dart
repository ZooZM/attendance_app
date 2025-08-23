import 'package:attendance_app/src/data/datasources/remote/api_client.dart';
import 'package:attendance_app/src/data/models/user_model.dart';

abstract class RemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> createAccount(
    String userName,
    String email,
    String password,
  );
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiClient apiClient;

  RemoteDataSourceImpl(this.apiClient);

  @override
  Future<UserModel> login(String email, String password) async {
    return await apiClient.login({"email": email, "password": password});
  }

  @override
  Future<UserModel> createAccount(
    String userName,
    String email,
    String password,
  ) async {
    return await apiClient.createAccount({
      "username": userName,
      "email": email,
      "password": password,
    });
  }
}
