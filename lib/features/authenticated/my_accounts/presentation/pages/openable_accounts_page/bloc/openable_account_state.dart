part of 'openable_account_bloc.dart';

sealed class OpenableAccountState extends Equatable {
  const OpenableAccountState();

  @override
  List<Object> get props => [];
}

final class OpenableAccountInitial extends OpenableAccountState {}

final class OpenableAccountLoading extends OpenableAccountState {}

final class OpenableAccountSuccess extends OpenableAccountState {
  final List<TenureEntity> tenures;

  const OpenableAccountSuccess(this.tenures);

  @override
  List<Object> get props => [tenures];
}

final class OpenableAccountError extends OpenableAccountState {
  final String error;
  const OpenableAccountError(this.error);

  @override
  List<Object> get props => [error];
}
