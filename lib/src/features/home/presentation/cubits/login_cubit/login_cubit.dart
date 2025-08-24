import 'package:attendance_app/src/core/models/user_model.dart';
import 'package:attendance_app/src/features/home/domain/usecases/login_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase) : super(LoginInitial());
  final LoginUseCase loginUseCase;

  void login(String email, String password) async {
    emit(LoginLoading());
    final result = await loginUseCase.call(
      LoginParams(email: email, password: password),
    );
    result.fold(
      (failure) => emit(LoginFailure(failure.failurMsg)),
      (user) => emit(LoginSuccess(user)),
    );
  }
}
