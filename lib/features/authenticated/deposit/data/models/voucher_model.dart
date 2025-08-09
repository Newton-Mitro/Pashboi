import 'package:pashboi/features/authenticated/deposit/data/models/transaction_model.dart';
import 'package:pashboi/features/authenticated/deposit/domain/entities/voucher_entity.dart';

class DepositRequestModel extends DepositRequestEntity {
  DepositRequestModel({
    super.id,
    required super.transactions,
    required super.requestdBy,
    required super.requestDate,
    required super.depositDate,
    required super.transactionType,
    required super.transactionMethod,
    required super.status,
  });

  factory DepositRequestModel.fromJson(Map<String, dynamic> json) {
    return DepositRequestModel(
      id: json['Id'] ?? 0,
      status: json['Status'] ?? '',
      requestDate: DateTime.parse(
        json['RequestDate'] ?? DateTime.now().toString(),
      ),
      depositDate: DateTime.parse(
        json['DepositDate'] ?? DateTime.now().toString(),
      ),
      requestdBy: json['AccHolder'] ?? '',
      transactionMethod: json['TransactionMethod'] ?? '',
      transactionType: json['TransactionType'] ?? '',
      transactions:
          (json['Details'] as List<dynamic>)
              .map((t) => TransactionModel.fromJson(t))
              .toList(),
    );
  }
}
