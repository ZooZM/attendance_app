import 'package:attendance_app/constants.dart';
import 'package:attendance_app/src/core/utils/styles.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/update_user_cubit/update_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/src/features/user/domain/entities/user_fronted_detailes_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersTable extends StatefulWidget {
  final List<UserEntity> users;
  final void Function(UserEntity user)? onRowTap;

  const UsersTable({super.key, required this.users, this.onRowTap});

  @override
  State<UsersTable> createState() => _UsersTableState();
}

class _UsersTableState extends State<UsersTable> {
  String? selectedUserId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "userName",
                  style: Styles.subtitle18Bold.copyWith(color: kWhite),
                ),
              ),
              Expanded(
                child: Text(
                  "name",
                  style: Styles.subtitle18Bold.copyWith(color: kWhite),
                ),
              ),
              Expanded(
                child: Text(
                  "attendance",
                  style: Styles.subtitle16Bold.copyWith(color: kWhite),
                ),
              ),

              Text(
                "Edit",
                style: Styles.subtitle16Bold.copyWith(color: kWhite),
              ),
            ],
          ),
        ),
        ...widget.users.map((user) {
          final isSelected = selectedUserId == user.id;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedUserId = user.id;
              });
              if (widget.onRowTap != null) {
                widget.onRowTap!(user);
              }
            },
            child: Container(
              color: isSelected ? Colors.blue.shade50 : Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Expanded(child: Text(user.userName)),
                  Expanded(child: Text(user.name)),
                  Expanded(
                    child: user.attendance != "null"
                        ? Text(
                            user.attendance,
                            style: TextStyle(
                              color: user.attendance.toLowerCase() == "check_in"
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          )
                        : const Text(
                            "Present",
                            style: TextStyle(color: Colors.red),
                          ),
                  ),

                  GestureDetector(
                    child: Icon(Icons.edit, color: kPrimaryColor),
                    onTap: () {
                      context.read<UpdateUserCubit>().routeUser(user);
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
