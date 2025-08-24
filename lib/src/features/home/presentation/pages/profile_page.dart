import 'package:attendance_app/src/core/utils/service_locator.dart';
import 'package:attendance_app/src/features/home/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:attendance_app/src/features/home/presentation/pages/custtom_app_bar.dart';
import 'package:attendance_app/src/features/home/presentation/widgets/profile_body.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/delete_user_cubit/delete_user_cubit_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/update_user_cubit/update_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<LoginCubit>()),
          BlocProvider(create: (_) => getIt<UpdateUserCubit>()),
          BlocProvider(create: (_) => getIt<DeleteUserCubit>()),
        ],
        child: ProfileBody(),
      ),
    );
  }
}
