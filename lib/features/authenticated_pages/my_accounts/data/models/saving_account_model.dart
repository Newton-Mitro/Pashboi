import 'package:pashboi/features/authenticated_pages/my_accounts/data/models/nominee_model.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/domain/entities/saving_account_entity.dart';

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
    required super.status,
    required super.defaultAccount,
    required super.nominees,
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
      interestReate: (json['InterestRate'] ?? 0).toDouble(),
      accountFor: json['AccountFor'] ?? '',
      status: json['Status'] ?? '',
      defaultAccount: (json['IsDefaulter'] ?? false) == true,
      nominees:
          (json['Nominees'] as List<dynamic>? ?? [])
              .map((e) => NomineeModel.fromJson(e as Map<String, dynamic>))
              .toList(),
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
      'Status': status,
      'IsDefaulter': defaultAccount,
      'Nominees':
          nominees.map((n) {
            if (n is NomineeModel) {
              return n.toJson();
            }
            throw Exception('Nominee is not a NomineeModel');
          }).toList(),
    };
  }
}
