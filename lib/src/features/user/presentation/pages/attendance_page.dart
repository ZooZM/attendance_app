import 'package:attendance_app/src/core/utils/service_locator.dart';
import 'package:attendance_app/src/features/home/presentation/pages/custtom_app_bar.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/change_attendance_state/change_attendance_state_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/update_user_cubit/update_user_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/fetch_users_cubit/fetch_users_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/widgets/attendance_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Attendance"),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<FetchUsersCubit>()),
          BlocProvider(create: (_) => getIt<ChangeAttendanceStateCubit>()),
          BlocProvider(create: (_) => getIt<UpdateUserCubit>()),
        ],
        child: AttendanceBody(),
      ),
    );
  }
}
