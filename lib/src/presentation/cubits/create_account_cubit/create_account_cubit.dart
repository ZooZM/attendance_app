import 'package:attendance_app/src/data/models/user_model.dart';
import 'package:attendance_app/src/domain/usecases/craete_acount_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit(this.createAccountUseCase) : super(CreateAccountInitial());
  final CreateAccountUseCase createAccountUseCase;
  Future<void> createAccount(CreateAccountParams params) async {
    emit(CreateAccountLoading());
    final result = await createAccountUseCase.call(params);
    result.fold(
      (failure) => emit(CreateAccountFailure(failure.failurMsg)),
      (user) => emit(CreateAccountSuccess(user)),
    );
  }
}
