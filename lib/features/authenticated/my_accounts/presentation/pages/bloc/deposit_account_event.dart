part of 'deposit_account_bloc.dart';

sealed class DepositAccountEvent extends Equatable {
  const DepositAccountEvent();

  @override
  List<Object> get props => [];
}

class LoadMyAccounts extends DepositAccountEvent {}

class LoadAccountStatement extends DepositAccountEvent {}

class LoadAccountTenures extends DepositAccountEvent {}

class LoadAccountInstallmentAmounts extends DepositAccountEvent {
  final String tenureId;
  const LoadAccountInstallmentAmounts(this.tenureId);
}

class CreateDepositAccount extends DepositAccountEvent {
  final DepositAccountEntity depositAccount;
  const CreateDepositAccount(this.depositAccount);
}
