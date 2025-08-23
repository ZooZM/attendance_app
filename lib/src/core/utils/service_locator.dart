import 'package:attendance_app/src/data/datasources/local/local_data_source.dart';
import 'package:attendance_app/src/data/datasources/remote/api_client.dart';
import 'package:attendance_app/src/data/datasources/remote/remote_data_source.dart';
import 'package:attendance_app/src/data/repositories/auth_repo_impl.dart';
import 'package:attendance_app/src/domain/repositories/auth_repo.dart';
import 'package:attendance_app/src/domain/usecases/craete_acount_use_case.dart';
import 'package:attendance_app/src/domain/usecases/login_use_case.dart';
import 'package:attendance_app/src/presentation/cubits/create_account_cubit/create_account_cubit.dart';
import 'package:attendance_app/src/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt()));

  getIt.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getIt(), getIt()));

  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateAccountUseCase(getIt()));

  getIt.registerFactory(() => LoginCubit(getIt()));
  getIt.registerFactory(() => CreateAccountCubit(getIt()));
}
