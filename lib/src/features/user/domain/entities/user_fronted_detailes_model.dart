class UserEntity {
  final String id;
  final String email;
  final String attendance;
  final String userName;

  UserEntity({
    required this.userName,
    required this.id,
    required this.email,
    required this.attendance,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as String,
      email: json['email'] as String,
      attendance: json['attendance'] as String,
      userName: json['userName'] as String,
    );
  }
}
