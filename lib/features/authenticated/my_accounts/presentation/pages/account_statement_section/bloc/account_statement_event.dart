part of 'account_statement_bloc.dart';

sealed class AccountStatementEvent extends Equatable {
  const AccountStatementEvent();

  @override
  List<Object> get props => [];
}

class FetchAccountStatementEvent extends AccountStatementEvent {
  final String accountNumber;
  const FetchAccountStatementEvent({required this.accountNumber});

  @override
  List<Object> get props => [accountNumber];
}
