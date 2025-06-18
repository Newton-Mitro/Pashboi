part of 'deposit_account_bloc.dart';

sealed class DepositAccountState extends Equatable {
  const DepositAccountState();

  @override
  List<Object> get props => [];
}

final class DepositAccountInitial extends DepositAccountState {}

final class DepositAccountsLoading extends DepositAccountInitial {}

final class DepositAccountsLoaded extends DepositAccountInitial {
  final List<DepositAccountEntity> depositAccounts;
  DepositAccountsLoaded(this.depositAccounts);
}

final class DepositAccountError extends DepositAccountInitial {
  final String message;
  DepositAccountError(this.message);
}
