import 'package:pashboi/core/entities/entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/nominee_entity.dart';

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
  final String status;
  final bool defaultAccount;
  final List<NomineeEntity> nominees;

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
    required this.status,
    required this.defaultAccount,
    required this.nominees,
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
    status,
    defaultAccount,
    nominees,
  ];
}
