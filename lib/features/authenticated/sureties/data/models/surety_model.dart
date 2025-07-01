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
    id: json['id'] ?? 0,
    loanNumber: json['LoanId'] ?? '',
    loanOpenDate:
        json['LoanOpenDate'] != null
            ? DateTime.parse(json['LoanOpenDate'])
            : null,
    suretyAccountNumber: json['MemberAccount'] ?? json['AccountNo'],
    accountHolderName: json['MemberName'] ?? '',
    mobileNumber: json['MemberMobileNo'] ?? '',
    collateralType: json['CollateralName'] ?? '',
    loanAmount: (json['LoanAmount'] ?? 0).toDouble(),
    suretyAmount: (json['SuretyAmount'] ?? 0).toDouble(),
    loanBalance: (json['LoanBalance'] ?? 0).toDouble(),
    suretyReleaseAmount: (json['SuretyRelaseAmount'] ?? 0).toDouble(),
    loanStartDate:
        json['StartDate'] != null ? DateTime.parse(json['StartDate']) : null,
    loanEndDate:
        json['EndDate'] != null ? DateTime.parse(json['EndDate']) : null,
    lastPaidDate:
        json['LastPaidDate'] != null
            ? DateTime.parse(json['LastPaidDate'])
            : null,
    defaulter: json['DefaulterStatus'] ?? false,
    defaulterReason: json['DefaultDetails'] ?? '',
    status: json['SurityStatus'] ?? '',
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
