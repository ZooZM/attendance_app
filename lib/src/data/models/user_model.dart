import 'package:attendance_app/src/data/models/attendance_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class UserModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String role;

  @HiveField(4)
  final String userName;

  @HiveField(5)
  final List<AttendanceModel> attendance;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final String password;

  UserModel({
    required this.password,
    required this.createdAt,
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.userName,
    required this.attendance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
