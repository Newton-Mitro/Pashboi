import 'package:pashboi/features/authenticated/deposit/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    super.id,
    required super.requestId,
    required super.amount,
    required super.accountNumber,
    required super.accountHolder,
    required super.perticulars,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? 0,
      accountNumber: json['TransferToAcc'] ?? '',
      perticulars: json['Particulars'] ?? '',
      accountHolder: json['AccHolder'] ?? '',
      amount: (json['Amount'] as num).toDouble(),
      requestId: json['TransferRequestId'] ?? '',
    );
  }
}
