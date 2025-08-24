import 'package:attendance_app/src/features/user/domain/entities/user_fronted_detailes_model.dart';
import 'package:attendance_app/src/features/user/domain/usercases/fetch_users_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fetch_users_state.dart';

class FetchUsersCubit extends Cubit<FetchUsersState> {
  FetchUsersCubit(this.fetchUsersUseCase) : super(FetchUsersInitial());
  final FetchUsersUseCase fetchUsersUseCase;

  Future<void> fetchUsers() async {
    emit(FetchUsersLoading());
    final result = await fetchUsersUseCase();
    result.fold(
      (failure) => emit(FetchUsersError(failure.failurMsg)),
      (users) => emit(FetchUsersLoaded(users)),
    );
  }
}
