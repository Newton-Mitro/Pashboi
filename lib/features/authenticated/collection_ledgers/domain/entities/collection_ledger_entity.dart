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

  final double amount;
  final double depositAmount;

  final bool multiplier;
  final bool editable;

  final double loanBalance;
  final bool lps;
  final double intrestRate;
  final DateTime lastPaidDate;
  final bool refundBased;

  final String accountFor;
  final bool isSelected;

  CollectionLedgerEntity({
    super.id,
    required this.accountNumber,
    required this.accountName,
    required this.ledgerName,
    required this.accountTypeCode,
    required this.amount,
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
    this.isSelected = false,
  });

  CollectionLedgerEntity copyWith({
    int? id,
    int? accountId,
    String? accountNumber,
    String? accountName,
    String? accountTypeCode,
    int? ledgerId,
    String? ledgerName,
    bool? subledger,
    int? plType,
    String? loanCollectionType,
    bool? defaultAccount,
    double? amount,
    double? depositAmount,
    bool? multiplier,
    bool? editable,
    double? loanBalance,
    bool? lps,
    double? intrestRate,
    DateTime? lastPaidDate,
    bool? refundBased,
    String? accountFor,
    bool? isSelected,
  }) {
    return CollectionLedgerEntity(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      accountTypeCode: accountTypeCode ?? this.accountTypeCode,
      ledgerId: ledgerId ?? this.ledgerId,
      ledgerName: ledgerName ?? this.ledgerName,
      subledger: subledger ?? this.subledger,
      plType: plType ?? this.plType,
      loanCollectionType: loanCollectionType ?? this.loanCollectionType,
      defaultAccount: defaultAccount ?? this.defaultAccount,
      amount: amount ?? this.amount,
      depositAmount: depositAmount ?? this.depositAmount,
      multiplier: multiplier ?? this.multiplier,
      editable: editable ?? this.editable,
      loanBalance: loanBalance ?? this.loanBalance,
      lps: lps ?? this.lps,
      intrestRate: intrestRate ?? this.intrestRate,
      lastPaidDate: lastPaidDate ?? this.lastPaidDate,
      refundBased: refundBased ?? this.refundBased,
      accountFor: accountFor ?? this.accountFor,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [
    id,
    accountNumber,
    accountName,
    ledgerName,
    accountTypeCode,
    amount,
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
    isSelected,
  ];
}
