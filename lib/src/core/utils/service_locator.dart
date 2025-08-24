import 'package:attendance_app/src/features/home/data/datasources/local/local_data_source.dart';
import 'package:attendance_app/src/core/api/api_client.dart';
import 'package:attendance_app/src/features/home/data/datasources/remote/remote_data_source.dart';
import 'package:attendance_app/src/features/home/data/repositories/auth_repo_impl.dart';
import 'package:attendance_app/src/features/home/domain/repositories/auth_repo.dart';
import 'package:attendance_app/src/features/home/domain/usecases/craete_acount_use_case.dart';
import 'package:attendance_app/src/features/home/domain/usecases/login_use_case.dart';
import 'package:attendance_app/src/features/home/presentation/cubits/create_account_cubit/create_account_cubit.dart';
import 'package:attendance_app/src/features/home/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:attendance_app/src/features/user/data/datasource/local/user_local_data_source.dart';
import 'package:attendance_app/src/features/user/data/datasource/remote/user_remote_data_source.dart';
import 'package:attendance_app/src/features/user/data/repositories/user_repo_impl.dart';
import 'package:attendance_app/src/features/user/domain/repositories/user_repo.dart';
import 'package:attendance_app/src/features/user/domain/usercases/fetch_users_use_case.dart';
import 'package:attendance_app/src/features/user/presentation/cubits/fetch_users_cubit/fetch_users_cubit.dart';
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
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getIt(), getIt()));

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt(), getIt()),
  );

  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => CreateAccountUseCase(getIt()));
  getIt.registerLazySingleton(() => FetchUsersUseCase(getIt()));

  getIt.registerFactory(() => LoginCubit(getIt()));
  getIt.registerFactory(() => CreateAccountCubit(getIt()));
  getIt.registerFactory(() => FetchUsersCubit(getIt()));
}
