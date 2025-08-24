import 'package:attendance_app/src/core/models/attendance_model.dart';

class UserEntity {
  final String id;
  final String name;
  final String email;
  final AttendanceModel? lastAttendance;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.lastAttendance,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    final attendancesJson = json['attendances'] as List<dynamic>?;

    return UserEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      lastAttendance: (attendancesJson == null || attendancesJson.isEmpty)
          ? null
          : UserEntity.getLastAttendance(
              attendancesJson
                  .map(
                    (e) => AttendanceModel.fromJson(e as Map<String, dynamic>),
                  )
                  .toList(),
            ),
    );
  }

  static AttendanceModel? getLastAttendance(List<AttendanceModel> attendances) {
    if (attendances.isEmpty) return null;
    attendances.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return attendances.first;
  }
}
