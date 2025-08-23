import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'attendance_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class AttendanceModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String userId;
  @HiveField(2)
  final DateTime commingeDate;
  @HiveField(3)
  final DateTime leavingDate;
  @HiveField(4)
  final String status;

  AttendanceModel({
    required this.id,
    required this.userId,
    required this.commingeDate,
    required this.leavingDate,
    required this.status,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceModelToJson(this);
}
