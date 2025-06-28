import 'package:pashboi/core/entities/entity.dart';

class LoanTransactionEntity extends Entity<int> {
  final String loanNumber;
  final DateTime? transactionDate;
  final String particulars;
  final double debitAmount;
  final double creditAmount;
  final double balanceAmount;
  final double loanIssuedAmount;

  LoanTransactionEntity({
    required int id,
    required this.loanNumber,
    required this.transactionDate,
    required this.particulars,
    required this.debitAmount,
    required this.creditAmount,
    required this.balanceAmount,
    required this.loanIssuedAmount,
  }) : super(id: id);

  @override
  List<Object?> get props => [
    id,
    loanNumber,
    transactionDate,
    particulars,
    debitAmount,
    creditAmount,
    balanceAmount,
    loanIssuedAmount,
  ];
}
