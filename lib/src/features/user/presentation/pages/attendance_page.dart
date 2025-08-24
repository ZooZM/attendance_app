import 'package:attendance_app/src/core/utils/service_locator.dart';
import 'package:attendance_app/src/features/home/presentation/pages/custtom_app_bar.dart';
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
      body: BlocProvider(
        create: (_) => getIt<FetchUsersCubit>(),
        child: AttendanceBody(),
      ),
    );
  }
}
