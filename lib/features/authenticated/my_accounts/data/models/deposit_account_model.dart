import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';

class DepositAccountModel extends DepositAccountEntity {
  DepositAccountModel({
    required super.id,
    required super.number,
    required super.name,
    required super.shortTypeName,
    required super.typeName,
    required super.typeCode,
    required super.balance,
    required super.withdrawableBalance,
    required super.lastPaidDate,
    required super.nominees,
    required super.maturityDate,
    required super.ledgerId,
    required super.interestReate,
    required super.accountFor,
    required super.status,
    required super.defaultAccount,
  });

  factory DepositAccountModel.fromJson(Map<String, dynamic> json) {
    return DepositAccountModel(
      id: json['AccountId'],
      number: json['AccountNo'] ?? '',
      name: json['DCAccountNo'] ?? '',
      typeName: json['AccountTypeName'] ?? '',
      shortTypeName: json['AccountTypeShortName'] ?? '',
      typeCode: json['AccountTypeCode'] ?? '00',
      balance: (json['Balance'] ?? 0).toDouble(),
      withdrawableBalance: (json['WithdrawableBalance'] ?? 0).toDouble(),
      lastPaidDate:
          json['LastPaidDate'] != null
              ? DateTime.tryParse(json['LastPaidDate'])
              : null,
      nominees: json['AccountNominees'] ?? '',
      maturityDate:
          json['MaturityDate'] != null
              ? DateTime.tryParse(json['MaturityDate'])
              : null,
      ledgerId: json['LedgerId'] ?? 0,
      interestReate: (json['InterestRate'] ?? 0).toDouble(),
      accountFor: json['AccountFor'] ?? 'Individual',
      status: json['Status'] ?? 'Active',
      defaultAccount: json['IsDefaulter'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AccountId': id,
      'AccountNumber': number,
      'AccountTypeName': typeName,
      'AccountTypeCode': typeCode,
      'DCAccountNo': name,
      'Balance': balance,
      'WithdrawableBalance': withdrawableBalance,
      'LastPaidDate': lastPaidDate?.toIso8601String(),
      'AccountNominees': nominees,
      'MaturityDate': maturityDate?.toIso8601String(),
      'LedgerId': ledgerId,
      'InterestRate': interestReate,
      'AccountFor': accountFor,
      'Status': status,
      'IsDefaulter': defaultAccount,
    };
  }
}
