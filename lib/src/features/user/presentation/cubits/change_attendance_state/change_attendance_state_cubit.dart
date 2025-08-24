import 'package:attendance_app/src/features/user/domain/usercases/change_attendance_state_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_attendance_state_state.dart';

class ChangeAttendanceStateCubit extends Cubit<ChangeAttendanceStateState> {
  ChangeAttendanceStateCubit(this.changeAttendanceStateUseCase)
    : super(ChangeAttendanceStateInitial());
  final ChangeAttendanceStateUseCase changeAttendanceStateUseCase;
  Future<void> changeAttendanceState(String userId, String newState) async {
    emit(ChangeAttendanceStateLoading());
    final params = ChangeAttendanceStateParams(
      userId: userId,
      newState: newState,
    );
    final result = await changeAttendanceStateUseCase.call(params);
    result.fold(
      (failure) => emit(ChangeAttendanceStateFailure(failure.failurMsg)),
      (success) => emit(ChangeAttendanceStateSuccess()),
    );
  }
}
