class UserEntity {
  final String id;
  final String name;
  final String email;
  final String attendance;
  final String userName;
  final String role;

  UserEntity({
    required this.userName,
    required this.id,
    required this.name,
    required this.email,
    required this.attendance,
    required this.role,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      attendance: json['attendance'] as String,
      userName: json['userName'] as String,
      role: json['role'] as String,
    );
  }
}
