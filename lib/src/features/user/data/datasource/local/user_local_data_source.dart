import 'package:attendance_app/src/core/models/user_model.dart';
import 'package:hive/hive.dart';

abstract class UserLocalDataSource {
  Future<List<UserModel>> fetchUsers();
  Future<void> cacheUsers(List<UserModel> users);
  Future<void> updateUser(UserModel user);
  Future<UserModel?> getUserById(String userId);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  static const String _userBox = "userBox";

  @override
  Future<List<UserModel>> fetchUsers() async {
    final box = await Hive.openBox<UserModel>(_userBox);
    return box.values.toList();
  }

  @override
  Future<void> cacheUsers(List<UserModel> users) async {
    final box = await Hive.openBox<UserModel>(_userBox);
    await box.clear();
    await box.addAll(users);
  }

  @override
  Future<void> updateUser(UserModel user) async {
    final box = await Hive.openBox<UserModel>(_userBox);
    if (box.containsKey(user.id)) {
      await box.put(user.id, user);
    } else {
      throw Exception("User with id ${user.id} not found");
    }
  }

  @override
  Future<UserModel?> getUserById(String userId) async {
    final box = await Hive.openBox<UserModel>(_userBox);
    return box.get(userId);
  }
}
