import 'package:attendance_app/src/features/user/domain/entities/user_fronted_detailes_model.dart';
import 'package:flutter/material.dart';

class UsersTable extends StatelessWidget {
  final List<UserEntity> users;

  const UsersTable({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(Colors.blue.shade100),
        border: TableBorder.all(color: Colors.grey.shade300),
        columns: const [
          DataColumn(label: Text("ID")),
          DataColumn(label: Text("Name")),
          DataColumn(label: Text("Email")),
          DataColumn(label: Text("Last Attendance")),
        ],
        rows: users
            .map(
              (user) => DataRow(
                cells: [
                  DataCell(Text(user.id)),
                  DataCell(Text(user.name)),
                  DataCell(Text(user.email)),
                  DataCell(
                    Text(
                      user.lastAttendance != null
                          ? user.lastAttendance!.createdAt.toString()
                          : "No Record",
                      style: TextStyle(
                        color: user.lastAttendance != null
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
