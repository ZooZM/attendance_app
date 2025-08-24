import 'package:attendance_app/src/core/models/user_model.dart';
import 'package:attendance_app/src/features/user/domain/entities/user_fronted_detailes_model.dart';
import 'package:attendance_app/src/features/user/domain/usercases/update_user_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit(this._updateUserUseCase) : super(UpdateUserInitial());

  final UpdateUserUseCase _updateUserUseCase;

  void routeUser(UserEntity user) {
    emit(UpdateUserLoading());
    emit(UpdateUserRoute(user));
  }

  Future<void> updateUser(UserModel user) async {
    emit(UpdateUserLoading());
    final result = await _updateUserUseCase.call(user);
    result.fold(
      (failure) => emit(UpdateUserFailure(failure.failurMsg)),
      (user) => emit(UpdateUserSuccess()),
    );
  }
}
