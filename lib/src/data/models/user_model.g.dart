// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      hasedPassword: fields[7] as String,
      createdAt: fields[6] as DateTime,
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      role: fields[3] as String,
      code: fields[4] as String,
      attendance: (fields[5] as List).cast<AttendanceModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.code)
      ..writeByte(5)
      ..write(obj.attendance)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.hasedPassword);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  hasedPassword: json['hasedPassword'] as String? ?? 'hasedPassword',
  createdAt: DateTime.parse(json['createdAt'] as String),
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  role: json['role'] as String,
  code: json['code'] as String,
  attendance: (json['attendance'] as List<dynamic>)
      .map((e) => AttendanceModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'role': instance.role,
  'code': instance.code,
  'attendance': instance.attendance,
  'createdAt': instance.createdAt.toIso8601String(),
  'hasedPassword': instance.hasedPassword,
};
