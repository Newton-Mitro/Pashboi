part of 'loan_statement_bloc.dart';

sealed class LoanStatementEvent extends Equatable {
  const LoanStatementEvent();

  @override
  List<Object> get props => [];
}

class FetchLoanStatementEvent extends LoanStatementEvent {
  final String loanNumber;
  const FetchLoanStatementEvent({required this.loanNumber});

  @override
  List<Object> get props => [loanNumber];
}
