import 'package:attendance_app/src/features/user/domain/entities/user_fronted_detailes_model.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/change_attendance_state/change_attendance_state_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/fetch_users_cubit/fetch_users_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/widgets/change_state_widget.dart';
import 'package:attendance_app/src/features/user/presentation/widgets/user_card.dart';
import 'package:attendance_app/src/features/user/presentation/widgets/users_taple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceBody extends StatefulWidget {
  const AttendanceBody({super.key});

  @override
  State<AttendanceBody> createState() => _AttendanceBodyState();
}

class _AttendanceBodyState extends State<AttendanceBody> {
  List<UserEntity> users = [];
  UserEntity? selectedUser;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _fetchUsers() async {
    await context.read<FetchUsersCubit>().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: MultiBlocListener(
        listeners: [
          BlocListener<FetchUsersCubit, FetchUsersState>(
            listener: (context, state) {
              if (state is FetchUsersLoaded) {
                setState(() {
                  users = state.users;
                  if (users.isNotEmpty && selectedUser == null) {
                    selectedUser = users.first;
                  }
                });
              } else if (state is FetchUsersError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
          BlocListener<ChangeAttendanceStateCubit, ChangeAttendanceStateState>(
            listener: (context, state) {
              if (!mounted) return;
              if (state is ChangeAttendanceStateSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Attendance state changed successfully'),
                  ),
                );
                // Refresh users after attendance change
                context.read<FetchUsersCubit>().fetchUsers();
              } else if (state is ChangeAttendanceStateFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to change attendance state'),
                  ),
                );
              }
            },
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserCard(
              userEntity:
                  selectedUser ??
                  UserEntity(
                    id: "",
                    name: "No User",
                    email: "",
                    attendance: "",
                    userName: "",
                    role: "",
                  ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: users.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: UsersTable(
                        users: users,
                        onRowTap: (user) {
                          setState(() {
                            selectedUser = user;
                          });
                        },
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            ChangeStateWidget(selectedUser: selectedUser),
          ],
        ),
      ),
    );
  }
}
