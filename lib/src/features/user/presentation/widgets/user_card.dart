import 'package:attendance_app/constants.dart';
import 'package:attendance_app/src/core/utils/styles.dart';
import 'package:attendance_app/src/features/user/domain/entities/user_fronted_detailes_model.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.userEntity});
  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("User: ${userEntity.name}", style: Styles.subtitle18Bold),
            SizedBox(height: 10),

            Text("Email: ${userEntity.email}", style: Styles.subtitle18Bold),
            Text("role: ${userEntity.role}", style: Styles.subtitle18Bold),
            SizedBox(height: 10),
            Text(
              "ID: ${userEntity.id}",
              style: Styles.subtitle16Bold.copyWith(color: kGray),
            ),
          ],
        ),
      ),
    );
  }
}
