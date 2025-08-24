part of 'fetch_single_user_cubit.dart';

sealed class FetchSingleUserState extends Equatable {
  const FetchSingleUserState();

  @override
  List<Object> get props => [];
}

final class FetchSingleUserInitial extends FetchSingleUserState {}

final class FetchSingleUserLoading extends FetchSingleUserState {}

final class FetchSingleUserSuccess extends FetchSingleUserState {
  final UserModel user;

  const FetchSingleUserSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class FetchSingleUserFailure extends FetchSingleUserState {
  final String message;

  const FetchSingleUserFailure(this.message);

  @override
  List<Object> get props => [message];
}
