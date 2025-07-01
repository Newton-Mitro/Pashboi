import 'package:pashboi/features/authenticated/sureties/domain/entities/surety_entity.dart';

class SuretyModel extends SuretyEntity {
  SuretyModel({
    required super.id,
    required super.loanNumber,
    required super.loanOpenDate,
    required super.suretyAccountNumber,
    required super.accountHolderName,
    required super.mobileNumber,
    required super.collateralType,
    required super.loanAmount,
    required super.suretyAmount,
    required super.loanBalance,
    required super.suretyReleaseAmount,
    required super.loanStartDate,
    required super.loanEndDate,
    required super.lastPaidDate,
    required super.defaulter,
    required super.defaulterReason,
    required super.status,
  });

  factory SuretyModel.fromJson(Map<String, dynamic> json) => SuretyModel(
    id: json['id'],
    loanNumber: json['loanNumber'],
    loanOpenDate:
        json['loanOpenDate'] != null
            ? DateTime.parse(json['loanOpenDate'])
            : null,
    suretyAccountNumber: json['suretyAccountNumber'],
    accountHolderName: json['accountHolderName'],
    mobileNumber: json['mobileNumber'],
    collateralType: json['collateralType'],
    loanAmount: (json['loanAmount'] ?? 0).toDouble(),
    suretyAmount: (json['suretyAmount'] ?? 0).toDouble(),
    loanBalance: (json['loanBalance'] ?? 0).toDouble(),
    suretyReleaseAmount: (json['suretyReleaseAmount'] ?? 0).toDouble(),
    loanStartDate:
        json['loanStartDate'] != null
            ? DateTime.parse(json['loanStartDate'])
            : null,
    loanEndDate:
        json['loanEndDate'] != null
            ? DateTime.parse(json['loanEndDate'])
            : null,
    lastPaidDate:
        json['lastPaidDate'] != null
            ? DateTime.parse(json['lastPaidDate'])
            : null,
    defaulter: json['defaulter'] ?? false,
    defaulterReason: json['defaulterReason'] ?? '',
    status: json['status'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'loanNumber': loanNumber,
    'loanOpenDate': loanOpenDate?.toIso8601String(),
    'suretyAccountNumber': suretyAccountNumber,
    'accountHolderName': accountHolderName,
    'mobileNumber': mobileNumber,
    'collateralType': collateralType,
    'loanAmount': loanAmount,
    'suretyAmount': suretyAmount,
    'loanBalance': loanBalance,
    'suretyReleaseAmount': suretyReleaseAmount,
    'loanStartDate': loanStartDate?.toIso8601String(),
    'loanEndDate': loanEndDate?.toIso8601String(),
    'lastPaidDate': lastPaidDate?.toIso8601String(),
    'defaulter': defaulter,
    'defaulterReason': defaulterReason,
    'status': status,
  };
}
