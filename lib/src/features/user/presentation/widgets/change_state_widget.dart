import 'package:attendance_app/constants.dart';
import 'package:attendance_app/src/features/user/domain/entities/user_fronted_detailes_model.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/change_attendance_state/change_attendance_state_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/widgets/user_custtom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeStateWidget extends StatelessWidget {
  const ChangeStateWidget({super.key, required this.selectedUser});

  final UserEntity? selectedUser;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeAttendanceStateCubit, ChangeAttendanceStateState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserCusttomButton(
              text: "Check In",
              color: kPrimaryColor,
              isLoading:
                  state is ChangeAttendanceStateLoading || selectedUser == null,
              onPressed: () {
                if (selectedUser != null &&
                    selectedUser!.attendance.toLowerCase() != "check In") {
                  context
                      .read<ChangeAttendanceStateCubit>()
                      .changeAttendanceState(selectedUser!.id, "check In");
                }
              },
            ),
            const SizedBox(height: 12),

            UserCusttomButton(
              text: "Check Out",
              color: kOrange,
              isLoading:
                  state is ChangeAttendanceStateLoading || selectedUser == null,
              onPressed: () {
                if (selectedUser != null &&
                    selectedUser!.attendance.toLowerCase() != "check Out") {
                  context
                      .read<ChangeAttendanceStateCubit>()
                      .changeAttendanceState(selectedUser!.id, "check Out");
                }
              },
            ),
          ],
        );
      },
    );
  }
}
