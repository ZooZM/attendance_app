import 'package:attendance_app/src/data/models/user_model.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

abstract class LocalDataSource {
  Future<void> storeUser(UserModel user);
  Future<List<UserModel>> getStoredUsers();
  Future<void> clearCache();
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(String userId);
  Future<UserModel?> getUserById(String userId);
  Future<UserModel?> getUserByUserNameOrEmail(
    String userNameOrEmail,
    bool isEmail,
  );
}

class LocalDataSourceImpl implements LocalDataSource {
  static const String _userBox = "userBox";

  @override
  Future<void> storeUser(UserModel user) async {
    final box = await Hive.openBox<UserModel>(_userBox);
    await box.put(user.id, user);
  }

  @override
  Future<List<UserModel>> getStoredUsers() async {
    final box = await Hive.openBox<UserModel>(_userBox);
    return box.values.toList();
  }

  @override
  Future<void> clearCache() async {
    final box = await Hive.openBox<UserModel>(_userBox);
    await box.clear();
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
  Future<void> deleteUser(String userId) async {
    final box = await Hive.openBox<UserModel>(_userBox);
    await box.delete(userId);
  }

  @override
  Future<UserModel?> getUserById(String userId) async {
    final box = await Hive.openBox<UserModel>(_userBox);
    return box.get(userId);
  }

  @override
  Future<UserModel?> getUserByUserNameOrEmail(
    String userNameOrEmail,
    bool isEmail,
  ) async {
    final box = await Hive.openBox<UserModel>(_userBox);

    final user = box.values.firstWhereOrNull(
      (user) => isEmail
          ? user.email == userNameOrEmail
          : user.userName == userNameOrEmail,
    );

    return user;
  }
}
