import 'package:pashboi/features/authenticated/transfer/domain/entities/dc_bank_entity.dart';

class DcBankModel extends DcBankEntity {
  DcBankModel({
    required super.id,
    required super.bankName,
    required super.bankAccNumber,
    required super.bankRoutingNo,
    required super.bankBranch,
  });

  factory DcBankModel.fromJson(Map<String, dynamic> json) {
    return DcBankModel(
      id: json['BankId'] as String,
      bankName: json['BankName'] as String,
      bankAccNumber: json['BankAccNumber'] as String,
      bankRoutingNo: json['BankRoutingNo'] as String,
      bankBranch: json['BankBranch'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BankId': id,
      'BankName': bankName,
      'BankAccNumber': bankAccNumber,
      'BankRoutingNo': bankRoutingNo,
      'BankBranch': bankBranch,
    };
  }
}
