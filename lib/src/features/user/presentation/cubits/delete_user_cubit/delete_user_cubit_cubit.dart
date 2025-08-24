import 'package:attendance_app/src/features/user/domain/usercases/delete_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_user_cubit_state.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  DeleteUserCubit(this.deleteUserUseCase) : super(DeleteUserInitial());
  final DeleteUserUseCase deleteUserUseCase;
  Future<void> deleteUser(String userId) async {
    emit(DeleteUserLoading());
    final result = await deleteUserUseCase.call(userId);
    result.fold(
      (failure) => emit(DeleteUserFailure(failure.failurMsg)),
      (success) => emit(DeleteUserSuccess()),
    );
  }
}
