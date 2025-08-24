part of 'change_attendance_state_cubit.dart';

sealed class ChangeAttendanceStateState extends Equatable {
  const ChangeAttendanceStateState();

  @override
  List<Object> get props => [];
}

final class ChangeAttendanceStateInitial extends ChangeAttendanceStateState {}

final class ChangeAttendanceStateLoading extends ChangeAttendanceStateState {}

final class ChangeAttendanceStateSuccess extends ChangeAttendanceStateState {}

final class ChangeAttendanceStateFailure extends ChangeAttendanceStateState {
  final String message;

  const ChangeAttendanceStateFailure(this.message);

  @override
  List<Object> get props => [message];
}
