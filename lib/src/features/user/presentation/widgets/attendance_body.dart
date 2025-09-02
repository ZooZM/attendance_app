import 'package:attendance_app/src/features/user/domain/entities/user_fronted_detailes_model.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/change_attendance_state/change_attendance_state_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/fetch_users_cubit/fetch_users_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/update_user_cubit/update_user_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/pages/update_user_page.dart';
import 'package:attendance_app/src/features/user/presentation/widgets/change_state_widget.dart';
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
  List<UserEntity> filteredUsers = [];
  UserEntity? selectedUser;
  bool isLoading = true;
  String failMes = '';
  String searchQuery = '';
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
                  filteredUsers = users;
                  if (users.isNotEmpty && selectedUser == null) {
                    selectedUser = users.first;
                  }
                  isLoading = false;
                });
              } else if (state is FetchUsersError) {
                failMes = state.message;
                isLoading = false;
                setState(() {});
              }
            },
          ),
          BlocListener<ChangeAttendanceStateCubit, ChangeAttendanceStateState>(
            listener: (context, state) {
              if (!mounted) return;
              if (state is ChangeAttendanceStateSuccess) {
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
          BlocListener<UpdateUserCubit, UpdateUserState>(
            listener: (context, state) {
              if (!mounted) return;
              if (state is UpdateUserRoute) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateUserPage(userId: state.user.id),
                  ),
                );
              }
              if (state is UpdateUserSuccess) {
                context.read<FetchUsersCubit>().fetchUsers();
              } else if (state is UpdateUserFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to update user')),
                );
              }
            },
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Search by usernames',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  filteredUsers = users
                      .where(
                        (user) => user.userName.toLowerCase().contains(
                          searchQuery.toLowerCase(),
                        ),
                      )
                      .toList();
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredUsers.isEmpty
                  ? Center(child: Text(failMes.isEmpty ? "No Users" : failMes))
                  : SingleChildScrollView(
                      child: UsersTable(
                        users: filteredUsers,
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
