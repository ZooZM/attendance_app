import 'package:attendance_app/src/features/home/presentation/widgets/custtom_button.dart';
import 'package:attendance_app/src/features/user/domain/entities/user_fronted_detailes_model.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/fetch_users_cubit/fetch_users_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/widgets/user_card.dart';
import 'package:attendance_app/src/features/user/presentation/widgets/usersTable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceBody extends StatefulWidget {
  const AttendanceBody({super.key});

  @override
  State<AttendanceBody> createState() => _AttendanceBodyState();
}

class _AttendanceBodyState extends State<AttendanceBody> {
  List<UserEntity> users = [];
  @override
  void initState() {
    context.read<FetchUsersCubit>().fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocConsumer<FetchUsersCubit, FetchUsersState>(
        listener: (context, state) {
          if (state is FetchUsersLoaded) {
            users = state.users;
          } else if (state is FetchUsersError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UserCard(
                userName: users.isNotEmpty ? users[0].name : "No User",
                currentStatus: users.isNotEmpty
                    ? users[0].lastAttendance?.status ?? "Unknown"
                    : "Unknown",
                lastAction: "-",
              ),
              const Spacer(),
              users.isEmpty
                  ? state is FetchUsersLoading
                        ? const Center(child: CircularProgressIndicator())
                        : const Text("No Users Found")
                  : Expanded(
                      child: SingleChildScrollView(
                        child: UsersTable(users: users),
                      ),
                    ),
              const Spacer(),
              CusttomButton(text: "Check In", isLoading: false),
              const SizedBox(height: 12),

              CusttomButton(text: "Check Out", isLoading: false),
            ],
          );
        },
      ),
    );
  }
}
