import 'package:pashboi/core/entities/entity.dart';
import 'package:pashboi/features/authenticated_pages/deposit/domain/entities/transaction_entity.dart';

class VoucherEntity extends Entity<int> {
  final String type;
  final String status;
  final DateTime date;
  final String reference;
  final String narration;
  final List<TransactionEntity> transactions;

  VoucherEntity({
    super.id,
    required this.type,
    required this.status,
    required this.date,
    required this.reference,
    required this.narration,
    required this.transactions,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    status,
    date,
    reference,
    narration,
    transactions,
  ];
}
