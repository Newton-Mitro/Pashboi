import 'package:pashboi/core/entities/entity.dart';

class TransactionEntity extends Entity<int> {
  final int voucherId;
  final int accountId;
  final double debit;
  final double credit;
  final String memo;

  TransactionEntity({
    super.id,
    required this.voucherId,
    required this.accountId,
    required this.debit,
    required this.credit,
    required this.memo,
  });

  @override
  List<Object?> get props => [id, voucherId, accountId, debit, credit, memo];
}
