import 'package:pashboi/core/entities/entity.dart';

class DepositAccountEntity extends Entity<int> {
  final String number;
  final String name;
  final String type;
  final String typeCode;
  final double balance;
  final double withdrawableBalance;
  final DateTime? lastPaidDate;
  final String nominees;
  final DateTime? maturityDate;
  final int ledgerId;
  final double interestReate;
  final String accountFor;
  final String status;
  final bool defaultAccount;

  DepositAccountEntity({
    required int id,
    required this.number,
    required this.name,
    required this.type,
    this.typeCode = '00',
    this.balance = 0.0,
    this.withdrawableBalance = 0.0,
    this.lastPaidDate,
    this.nominees = '',
    this.maturityDate,
    this.ledgerId = 0,
    this.interestReate = 0.0,
    this.accountFor = 'Individual',
    this.status = 'Active',
    this.defaultAccount = false,
  }) : super(id: id);

  @override
  List<Object?> get props => [
    id,
    number,
    name,
    type,
    typeCode,
    balance,
    withdrawableBalance,
    lastPaidDate,
    maturityDate,
    ledgerId,
    interestReate,
    accountFor,
    status,
    defaultAccount,
    nominees,
  ];
}
