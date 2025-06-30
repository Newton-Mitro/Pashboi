import 'package:pashboi/features/authenticated/deposit/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    super.id,
    required super.voucherId,
    required super.accountId,
    required super.debit,
    required super.credit,
    required super.balance,
    required super.memo,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      voucherId: json['voucher_id'],
      accountId: json['account_id'],
      debit: (json['debit'] as num).toDouble(),
      credit: (json['credit'] as num).toDouble(),
      balance: (json['balance'] as num).toDouble(),
      memo: json['memo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'voucher_id': voucherId,
      'account_id': accountId,
      'debit': debit,
      'credit': credit,
      'balance': balance,
      'memo': memo,
    };
  }
}
