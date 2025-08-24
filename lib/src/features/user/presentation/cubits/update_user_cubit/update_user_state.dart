part of 'update_user_cubit.dart';

sealed class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

final class UpdateUserInitial extends UpdateUserState {}

final class UpdateUserRoute extends UpdateUserState {
  final UserEntity user;

  const UpdateUserRoute(this.user);

  @override
  List<Object> get props => [user];
}

final class UpdateUserLoading extends UpdateUserState {}

final class UpdateUserSuccess extends UpdateUserState {}

final class UpdateUserFailure extends UpdateUserState {
  final String message;

  const UpdateUserFailure(this.message);

  @override
  List<Object> get props => [message];
}
