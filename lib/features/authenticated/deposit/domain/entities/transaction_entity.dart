import 'package:pashboi/core/entities/entity.dart';

class TransactionEntity extends Entity<int> {
  final int requestId;
  final double amount;
  final String accountNumber;
  final String accountHolder;
  final String perticulars;

  TransactionEntity({
    super.id,
    required this.requestId,
    required this.amount,
    required this.accountNumber,
    required this.accountHolder,
    required this.perticulars,
  });

  @override
  List<Object?> get props => [
    id,
    requestId,
    amount,
    accountNumber,
    accountHolder,
    perticulars,
  ];
}
