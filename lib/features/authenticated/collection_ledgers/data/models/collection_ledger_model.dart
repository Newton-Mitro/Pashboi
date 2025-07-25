import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_ledger_entity.dart';

class CollectionLedgerModel extends CollectionLedgerEntity {
  CollectionLedgerModel({
    super.id,
    required super.accountNumber,
    required super.accountName,
    required super.ledgerName,
    required super.accountTypeCode,
    required super.moduleCode,
    required super.amount,
    required super.depositAmount,
    required super.accountId,
    required super.defaultAccount,
    required super.subledger,
    required super.multiplier,
    required super.editable,
    required super.lps,
    required super.ledgerId,
    required super.plType,
    required super.loanBalance,
    required super.intrestRate,
    required super.lastPaidDate,
    required super.refundBased,
    required super.collectionType,
    required super.accountFor,
    required super.isRefundBased,
    required super.isSelected,
  });

  factory CollectionLedgerModel.fromJson(Map<String, dynamic> json) {
    return CollectionLedgerModel(
      id: json['id'] ?? 0,
      accountNumber: json['AccountNo'] as String,
      accountName: json['AccountName'] as String,
      ledgerName: json['AccountType'] as String,
      accountTypeCode: json['AccountTypeCode'] as String,
      moduleCode: json['ModuleCode'] ?? '',
      amount: (json['Amount'] as num).toDouble(),
      depositAmount: (json['Amount'] as num).toDouble(),
      accountId: json['AccountId'] as int,
      ledgerId: json['LedgerId'] as int,
      defaultAccount: json['IsDefaulter'] as bool,
      subledger: json['IsSubLedger'] as bool,
      multiplier: json['IsMultiplier'] as bool,
      editable: json['IsNotEditable'] as bool,
      lps: json['IsLps'] as bool,
      plType: json['PlType'] as int,
      loanBalance: (json['LoanBalance'] as num).toDouble(),
      intrestRate: (json['InterestRate'] as num).toDouble(),
      lastPaidDate: DateTime.parse(json['LastPaidDate'] as String),
      refundBased: json['IsRefundBased'] as bool,
      collectionType: json['LoanCollectionType'] as String,
      accountFor: json['AccountFor'] as String,
      isRefundBased: json['IsRefundBased'] as bool,
      isSelected: false,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountNumber': accountNumber,
      'accountName': accountName,
      'ledgerName': ledgerName,
      'accountTypeCode': accountTypeCode,
      'moduleCode': moduleCode,
      'depositAmount': amount,
      'accountId': accountId,
      'ledgerId': ledgerId,
      'defaultAccount': defaultAccount,
      'subledger': subledger,
      'multiplier': multiplier,
      'editable': editable,
      'lps': lps,
      'plType': plType,
      'loanBalance': loanBalance,
      'intrestRate': intrestRate,
      'lastPaidDate': lastPaidDate.toIso8601String(),
      'refundBased': refundBased,
      'LoanCollectionType': collectionType,
      'isRefundBased': isRefundBased,
      'accountFor': accountFor,
    };
  }
}
