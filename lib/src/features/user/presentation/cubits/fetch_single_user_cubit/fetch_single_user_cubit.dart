import 'package:attendance_app/src/core/models/user_model.dart';
import 'package:attendance_app/src/features/user/domain/usercases/fetch_user_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fetch_single_user_state.dart';

class FetchSingleUserCubit extends Cubit<FetchSingleUserState> {
  FetchSingleUserCubit(this.fetchUserUseCase) : super(FetchSingleUserInitial());

  final FetchSingleUserUseCase fetchUserUseCase;

  Future<void> fetchUser(String userId) async {
    emit(FetchSingleUserLoading());
    final result = await fetchUserUseCase.call(userId);
    result.fold(
      (failure) => emit(FetchSingleUserFailure(failure.failurMsg)),
      (user) => emit(FetchSingleUserSuccess(user)),
    );
  }
}
