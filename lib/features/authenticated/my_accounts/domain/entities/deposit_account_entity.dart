import 'package:pashboi/core/entities/entity.dart';

class DepositAccountEntity extends Entity<int> {
  final String number;
  final String name;
  final String type;
  final double balance;
  final double withdrawableBalance;
  final String status;
  final DateTime? lastPaidDate;
  final String accountNominees;
  final DateTime? maturityDate;
  final int typeCode;
  final bool defaulter;

  DepositAccountEntity({
    required int id,
    required this.number,
    required this.name,
    required this.type,
    required this.balance,
    required this.withdrawableBalance,
    required this.status,
    required this.lastPaidDate,
    required this.accountNominees,
    required this.maturityDate,
    required this.typeCode,
    required this.defaulter,
  }) : super(id: id);

  @override
  List<Object?> get props => [
    id,
    number,
    name,
    type,
    balance,
    withdrawableBalance,
    status,
    lastPaidDate,
    accountNominees,
    maturityDate,
    typeCode,
    defaulter,
  ];
}
