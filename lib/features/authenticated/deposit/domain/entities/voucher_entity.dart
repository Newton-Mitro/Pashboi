import 'package:pashboi/core/entities/entity.dart';
import 'package:pashboi/features/authenticated/deposit/domain/entities/transaction_entity.dart';

class DepositRequestEntity extends Entity<int> {
  final String requestdBy;
  final DateTime requestDate;
  final DateTime depositDate;
  final String transactionType;
  final String transactionMethod;
  final String status;
  final List<TransactionEntity> transactions;

  DepositRequestEntity({
    super.id,
    required this.requestdBy,
    required this.requestDate,
    required this.depositDate,
    required this.transactionType,
    required this.transactionMethod,
    required this.status,
    required this.transactions,
  });

  @override
  List<Object?> get props => [
    id,
    requestdBy,
    requestDate,
    depositDate,
    transactionType,
    transactionMethod,
    status,
    transactions,
  ];
}
