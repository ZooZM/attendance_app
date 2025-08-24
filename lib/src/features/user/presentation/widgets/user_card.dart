import 'package:attendance_app/constants.dart';
import 'package:attendance_app/src/core/utils/styles.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.userName,
    required this.currentStatus,
    required this.lastAction,
  });
  final String userName;
  final String currentStatus;
  final String lastAction;

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
            Text("User: $userName", style: Styles.subtitle18Bold),
            SizedBox(height: 10),

            Text(
              "Current Status: $currentStatus",
              style: Styles.subtitle18Bold,
            ),
            SizedBox(height: 10),
            Text(
              "Last action: $lastAction",
              style: Styles.subtitle16Bold.copyWith(color: kGray),
            ),
          ],
        ),
      ),
    );
  }
}
