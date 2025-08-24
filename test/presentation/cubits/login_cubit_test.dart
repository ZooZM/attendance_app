import 'package:attendance_app/src/core/errors/failures.dart';
import 'package:attendance_app/src/core/models/user_model.dart';
import 'package:attendance_app/src/features/home/domain/usecases/login_use_case.dart';
import 'package:attendance_app/src/features/home/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class FakeLoginParams extends Fake implements LoginParams {}

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late LoginCubit loginCubit;
  setUpAll(() {
    registerFallbackValue(FakeLoginParams());
  });
  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    loginCubit = LoginCubit(mockLoginUseCase);
  });

  tearDown(() {
    loginCubit.close();
  });

  const tEmail = "test@example.com";
  const tPassword = "123456";
  final tUser = UserModel(
    id: "1",
    name: "John Doe",
    email: tEmail,
    role: 'user',
    userName: 'johndoe',
    attendance: [],
    createdAt: DateTime.now(),
    password: tPassword,
  );

  blocTest<LoginCubit, LoginState>(
    'emits [LoginLoading, LoginSuccess] when login succeeds',
    build: () {
      when(
        () => mockLoginUseCase.call(any()),
      ).thenAnswer((_) async => Right(tUser));
      return loginCubit;
    },
    act: (cubit) => cubit.login(tEmail, tPassword),
    expect: () => [
      isA<LoginLoading>(),
      isA<LoginSuccess>().having((s) => s.user.email, 'user email', tEmail),
    ],
    verify: (_) {
      verify(() => mockLoginUseCase.call(any())).called(1);
    },
  );

  blocTest<LoginCubit, LoginState>(
    'emits [LoginLoading, LoginFailure] when login fails',
    build: () {
      when(
        () => mockLoginUseCase.call(any()),
      ).thenAnswer((_) async => Left(ServerFailure("Invalid credentials")));
      return loginCubit;
    },
    act: (cubit) => cubit.login(tEmail, "wrong"),
    expect: () => [
      isA<LoginLoading>(),
      isA<LoginFailure>().having(
        (s) => s.error,
        'failure message',
        "Invalid credentials",
      ),
    ],
  );
}
