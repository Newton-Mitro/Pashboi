import 'package:pashboi/features/authenticated/my_accounts/domain/entities/account_transaction_entity.dart';

class AccountTransactionModel extends AccountTransactionEntity {
  AccountTransactionModel({
    super.id,
    required super.date,
    required super.particular,
    required super.debit,
    required super.credit,
    required super.balance,
  });

  factory AccountTransactionModel.fromJson(Map<String, dynamic> json) {
    return AccountTransactionModel(
      id: json['id'] ?? 0,
      date: DateTime.parse(json['TxnDate']),
      particular: json['Particulars'] as String,
      debit: (json['WithdrawAmount'] as num).toDouble(),
      credit: (json['DepositAmount'] as num).toDouble(),
      balance: (json['Balance'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'particular': particular,
      'debit': debit,
      'credit': credit,
      'balance': balance,
    };
  }
}
