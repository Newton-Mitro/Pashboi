import 'package:pashboi/features/authenticated/my_loans/domain/entities/loan_transaction_entity.dart';

class LoanTransactionModel extends LoanTransactionEntity {
  LoanTransactionModel({
    required super.id,
    required super.loanNumber,
    required super.transactionDate,
    required super.particulars,
    required super.debitAmount,
    required super.creditAmount,
    required super.balanceAmount,
    required super.loanIssuedAmount,
  });

  factory LoanTransactionModel.fromJson(Map<String, dynamic> json) {
    return LoanTransactionModel(
      id: json['id'] ?? 0,
      loanNumber: json['LoanId'] ?? '',
      transactionDate: DateTime.parse(json['TxnDate']),
      particulars: json['Particulars'] ?? '',
      debitAmount: (json['Withdrawal'] ?? 0).toDouble(),
      creditAmount: (json['Deposit'] ?? 0).toDouble(),
      balanceAmount: (json['Balance'] ?? 0).toDouble(),
      loanIssuedAmount: double.tryParse((json['LoanIssue']).toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'loanNumber': loanNumber,
      'transactionDate': transactionDate.toIso8601String(),
      'particulars': particulars,
      'debitAmount': debitAmount,
      'creditAmount': creditAmount,
      'balanceAmount': balanceAmount,
      'loanIssuedAmount': loanIssuedAmount,
    };
  }
}
