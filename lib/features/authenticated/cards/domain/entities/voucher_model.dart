import 'package:pashboi/features/authenticated/cards/domain/entities/transaction_model.dart';
import 'package:pashboi/features/authenticated/deposit/domain/entities/voucher_entity.dart';

class VoucherModel extends VoucherEntity {
  VoucherModel({
    super.id,
    required super.type,
    required super.status,
    required super.date,
    required super.reference,
    required super.narration,
    required super.transactions,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id'],
      type: json['type'],
      status: json['status'],
      date: DateTime.parse(json['date']),
      reference: json['reference'] ?? '',
      narration: json['narration'] ?? '',
      transactions:
          (json['transactions'] as List<dynamic>)
              .map((t) => TransactionModel.fromJson(t))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'status': status,
      'date': date.toIso8601String(),
      'reference': reference,
      'narration': narration,
      'transactions':
          transactions.map((e) => (e as TransactionModel).toJson()).toList(),
    };
  }
}
