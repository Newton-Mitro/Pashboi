part of 'loan_payment_bloc.dart';

sealed class LoanPaymentEvent extends Equatable {
  const LoanPaymentEvent();

  @override
  List<Object> get props => [];
}

class FetchLoanPayment extends LoanPaymentEvent {
  final int interestDays;
  final double interestRate;
  final double loanBalance;
  final double loanRefundAmount;
  final String moduleCode;
  final String? issuedDate;
  final String? lastPaidDate;

  const FetchLoanPayment({
    required this.interestDays,
    required this.interestRate,
    required this.loanBalance,
    required this.loanRefundAmount,
    required this.moduleCode,
    required this.issuedDate,
    required this.lastPaidDate,
  });
}
