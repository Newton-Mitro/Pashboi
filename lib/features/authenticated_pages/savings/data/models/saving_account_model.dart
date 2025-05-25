import 'package:pashboi/features/authenticated_pages/savings/domain/entities/saving_account_entity.dart';

class SavingAccountModel extends SavingAccountEntity {
  SavingAccountModel({
    required super.id,
    required super.number,
    required super.type,
    required super.typeCode,
    required super.accountName,
    required super.balance,
    required super.withdrawableBalance,
    required super.ledgerId,
    required super.interestReate,
    required super.accountFor,
  });

  factory SavingAccountModel.fromJson(Map<String, dynamic> json) {
    return SavingAccountModel(
      id: json['AccountId'],
      number: json['AccountNumber'] ?? '',
      type: json['AccountTypeName'] ?? '',
      typeCode: json['AccountTypeCode'] ?? '',
      accountName: json['DCAccountNo'] ?? '',
      balance: (json['Balance'] ?? 0).toDouble(),
      withdrawableBalance: (json['WithdrawableBalance'] ?? 0).toDouble(),
      ledgerId: json['LedgerId'] ?? 0,
      interestReate: (json['InterestRate'] ?? 0).toDouble(), // Optional
      accountFor: (json['AccountFor'] ?? ''), // Optional
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AccountId': id,
      'AccountNumber': number,
      'AccountTypeName': type,
      'AccountTypeCode': typeCode,
      'DCAccountNo': accountName,
      'Balance': balance,
      'WithdrawableBalance': withdrawableBalance,
      'LedgerId': ledgerId,
      'InterestRate': interestReate,
      'AccountFor': accountFor,
    };
  }
}
