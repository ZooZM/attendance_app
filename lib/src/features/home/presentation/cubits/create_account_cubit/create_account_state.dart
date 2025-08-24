part of 'create_account_cubit.dart';

sealed class CreateAccountState extends Equatable {
  const CreateAccountState();

  @override
  List<Object> get props => [];
}

final class CreateAccountInitial extends CreateAccountState {}

final class CreateAccountLoading extends CreateAccountState {}

final class CreateAccountSuccess extends CreateAccountState {
  final UserModel user;
  const CreateAccountSuccess(this.user);
  @override
  List<Object> get props => [user];
}

final class CreateAccountFailure extends CreateAccountState {
  final String error;
  const CreateAccountFailure(this.error);
  @override
  List<Object> get props => [error];
}
