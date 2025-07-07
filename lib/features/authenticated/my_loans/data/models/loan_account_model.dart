import 'package:intl/intl.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/entities/loan_account_entity.dart';

class LoanAccountModel extends LoanAccountEntity {
  LoanAccountModel({
    required super.id,
    required super.number,
    required super.typeName,
    super.shortTypeName,
    super.productCode,
    super.moduleCode,
    super.issuedAmount,
    required super.loanBalance,
    super.refundAmount,
    super.interestRate,
    super.interestForDays,
    super.numberOfInstallments,
    super.loanEndDate,
    super.lastPaidDate,
    super.issuedDate,
    super.loaneeName,
    super.defaulter,
    super.defaulterReason,
    super.status,
  });

  factory LoanAccountModel.fromJson(Map<String, dynamic> json) {
    return LoanAccountModel(
      id: json['id'] ?? 0,
      number: json['LoanNumber'] ?? json['LoanId'] ?? '',
      typeName: json['LoanType'] ?? '',
      shortTypeName: json['AccountTypeShortName'] ?? '',
      productCode: json['LoanProductCode'] ?? '',
      moduleCode: json['ModuleCode'] ?? '',
      issuedAmount: (json['IssuedAmount'] ?? 0).toDouble(),
      loanBalance: (json['LoanBalance'] ?? 0).toDouble(),
      refundAmount: (json['LoanRefundAmount'] ?? 0).toDouble(),
      interestRate: (json['InterestRate'] ?? 0).toDouble(),
      interestForDays: json['Days'] ?? 0,
      numberOfInstallments: json['Installment'] ?? '',
      loanEndDate:
          json['LoanEndDate'] != null
              ? DateTime.parse(json['LoanEndDate'])
              : null,
      lastPaidDate:
          json['LastPaidDate'] != null
              ? DateFormat('yyyy/MM/dd').parse(json['LastPaidDate'])
              : null,
      issuedDate:
          json['IssuedDate'] != null
              ? DateFormat('yyyy/MM/dd').parse(json['IssuedDate'])
              : null,
      loaneeName: json['LoaneeName'] ?? '',
      defaulter: json['IsDefaulter'] ?? false,
      defaulterReason: json['DefaultDetails'] ?? 'N/A',
      status: json['LoanStatus'] ?? 'Active',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'typeName': typeName,
      'shortTypeName': shortTypeName,
      'productCode': productCode,
      'moduleCode': moduleCode,
      'issuedAmount': issuedAmount,
      'loanBalance': loanBalance,
      'refundAmount': refundAmount,
      'interestRate': interestRate,
      'interestForDays': interestForDays,
      'numberOfInstallments': numberOfInstallments,
      'loanEndDate': loanEndDate?.toIso8601String(),
      'lastPaidDate': lastPaidDate?.toIso8601String(),
      'issuedDate': issuedDate?.toIso8601String(),
      'loaneeName': loaneeName,
      'defaulter': defaulter,
      'defaulterReason': defaulterReason,
      'status': status,
    };
  }
}
