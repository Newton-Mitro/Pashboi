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
      id: json['id'],
      loanNumber: json['loanNumber'] ?? '',
      transactionDate:
          json['transactionDate'] != null
              ? DateTime.parse(json['transactionDate'])
              : null,
      particulars: json['particulars'] ?? '',
      debitAmount: (json['debitAmount'] ?? 0).toDouble(),
      creditAmount: (json['creditAmount'] ?? 0).toDouble(),
      balanceAmount: (json['balanceAmount'] ?? 0).toDouble(),
      loanIssuedAmount: (json['loanIssuedAmount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'loanNumber': loanNumber,
      'transactionDate': transactionDate?.toIso8601String(),
      'particulars': particulars,
      'debitAmount': debitAmount,
      'creditAmount': creditAmount,
      'balanceAmount': balanceAmount,
      'loanIssuedAmount': loanIssuedAmount,
    };
  }
}
