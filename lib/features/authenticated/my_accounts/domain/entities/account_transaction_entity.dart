import 'package:pashboi/core/entities/entity.dart';

class AccountTransactionEntity extends Entity<int> {
  final DateTime date;
  final String particular;
  final double debit;
  final double credit;
  final double balance;

  AccountTransactionEntity({
    super.id,
    required this.date,
    required this.particular,
    required this.debit,
    required this.credit,
    required this.balance,
  });

  @override
  List<Object?> get props => [id, date, particular, debit, credit, balance];
}
