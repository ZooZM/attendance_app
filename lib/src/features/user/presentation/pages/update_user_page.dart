import 'package:attendance_app/src/core/utils/service_locator.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/delete_user_cubit/delete_user_cubit_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/fetch_single_user_cubit/fetch_single_user_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/fetch_users_cubit/fetch_users_cubit.dart';
import 'package:attendance_app/src/features/user/presentation/widgets/update_user_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/update_user_cubit/update_user_cubit.dart';

class UpdateUserPage extends StatelessWidget {
  const UpdateUserPage({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<FetchSingleUserCubit>()),
            BlocProvider(create: (context) => getIt<UpdateUserCubit>()),
            BlocProvider(create: (context) => getIt<DeleteUserCubit>()),
            BlocProvider(create: (context) => getIt<FetchUsersCubit>()),
          ],
          child: UpdateUserBody(userId: userId),
        ),
      ),
    );
  }
}
