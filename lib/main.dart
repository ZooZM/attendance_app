import 'package:attendance_app/src/core/utils/bloc_observer.dart';
import 'package:attendance_app/src/core/utils/service_locator.dart';
import 'package:attendance_app/src/core/models/user_model.dart';
import 'package:attendance_app/src/features/home/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:attendance_app/src/features/home/presentation/pages/login_page.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());
  Bloc.observer = MyBlocObserver();
  runApp(
    BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
