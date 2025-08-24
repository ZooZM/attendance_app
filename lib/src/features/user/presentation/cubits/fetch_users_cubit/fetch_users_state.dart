part of 'fetch_users_cubit.dart';

sealed class FetchUsersState extends Equatable {
  const FetchUsersState();

  @override
  List<Object> get props => [];
}

final class FetchUsersInitial extends FetchUsersState {}

final class FetchUsersLoading extends FetchUsersState {}

final class FetchUsersLoaded extends FetchUsersState {
  final List<UserEntity> users;

  const FetchUsersLoaded(this.users);

  @override
  List<Object> get props => [users];
}

final class FetchUsersError extends FetchUsersState {
  final String message;

  const FetchUsersError(this.message);

  @override
  List<Object> get props => [message];
}
