import 'package:attendance_app/src/core/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initHiveAndSeedUsers() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());

  final userBox = await Hive.openBox<UserModel>("userBox");

  if (userBox.isEmpty) {
    final List<UserModel> defaultUsers = [
      UserModel(
        id: '1',
        name: 'Admin User',
        email: 'admin@gmail.com',
        role: 'Admin',
        userName: 'admin',
        attendance: 'Present',
        createdAt: DateTime.now(),
        password: '12345678',
      ),
      UserModel(
        id: '2',
        name: 'Employee User',
        email: 'employee@gmail.com',
        role: 'Employee',
        userName: 'employee',
        attendance: 'Present',
        createdAt: DateTime.now(),
        password: '12345678',
      ),
      UserModel(
        id: '3',
        name: 'Customer User',
        email: 'customer@gmail.com',
        role: 'Customer',
        userName: 'customer',
        attendance: 'Present',
        createdAt: DateTime.now(),
        password: '12345678',
      ),
      UserModel(
        id: '4',
        name: 'Manager User',
        email: 'manager@gmail.com',
        role: 'Manager',
        userName: 'manager',
        attendance: 'Present',
        createdAt: DateTime.now(),
        password: '12345678',
      ),
    ];

    for (var user in defaultUsers) {
      await userBox.put(user.id, user);
    }

    print("Default users added to Hive.");
  } else {
    print("ℹUsers already exist in Hive, skipping seeding.");
  }
}
