import 'package:pashboi/core/entities/entity.dart';

class CollectionLedgerEntity extends Entity<int> {
  final int accountId;
  final String accountNumber;
  final String accountName;
  final String accountTypeCode;

  final int ledgerId;
  final String ledgerName;
  final bool subledger;
  final int plType;
  final String loanCollectionType;
  final bool defaultAccount;

  final double depositAmount;

  final bool multiplier;
  final bool editable;

  final double loanBalance;
  final bool lps;
  final double intrestRate;
  final DateTime lastPaidDate;
  final bool refundBased;

  final String accountFor;

  CollectionLedgerEntity({
    super.id,
    required this.accountNumber,
    required this.accountName,
    required this.ledgerName,
    required this.accountTypeCode,
    required this.depositAmount,
    required this.accountId,
    required this.defaultAccount,
    required this.subledger,
    required this.multiplier,
    required this.editable,
    required this.lps,
    required this.ledgerId,
    required this.plType,
    required this.loanBalance,
    required this.intrestRate,
    required this.lastPaidDate,
    required this.refundBased,
    required this.loanCollectionType,
    required this.accountFor,
  });

  @override
  List<Object?> get props => [
    id,
    accountNumber,
    accountName,
    ledgerName,
    accountTypeCode,
    depositAmount,
    accountId,
    ledgerId,
    defaultAccount,
    subledger,
    multiplier,
    editable,
    lps,
    plType,
    loanBalance,
    intrestRate,
    lastPaidDate,
    refundBased,
    loanCollectionType,
    accountFor,
  ];
}
