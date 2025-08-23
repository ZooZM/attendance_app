import 'package:attendance_app/src/core/utils/service_locator.dart';
import 'package:attendance_app/src/presentation/cubits/create_account_cubit/create_account_cubit.dart';
import 'package:attendance_app/src/presentation/pages/custtom_app_bar.dart';
import 'package:attendance_app/src/presentation/widgets/create_acount_formkey.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateAccountCubit>(),
      child: Scaffold(
        appBar: CustomAppBar(title: "Settings"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(children: [CreateAcountFormkey()]),
        ),
      ),
    );
  }
}
