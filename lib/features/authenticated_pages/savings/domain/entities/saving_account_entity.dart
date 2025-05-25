import 'package:pashboi/core/entities/entity.dart';

class SavingAccountEntity extends Entity<int> {
  final String number;
  final String type;
  final String typeCode;
  final String accountName;
  final double balance;
  final double withdrawableBalance;
  final int ledgerId;
  final double interestReate;
  final String accountFor;

  SavingAccountEntity({
    super.id,
    required this.number,
    required this.type,
    required this.typeCode,
    required this.accountName,
    required this.balance,
    required this.withdrawableBalance,
    required this.ledgerId,
    required this.interestReate,
    required this.accountFor,
  });

  @override
  List<Object?> get props => [
    id,
    number,
    type,
    typeCode,
    accountName,
    balance,
    withdrawableBalance,
    ledgerId,
    interestReate,
    accountFor,
  ];
}
