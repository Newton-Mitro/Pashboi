import 'package:pashboi/core/entities/entity.dart';

class LoanAccountEntity extends Entity<int> {
  final String number;

  final String type;
  final int productCode;
  final int moduleCode;

  final double issuedAmount;
  final double loanBalance;
  final double refundAmount;

  final double interestRate;
  final int interestForDays;
  final String numberOfInstallments;

  final DateTime? loanEndDate;
  final DateTime? lastPaidDate;
  final DateTime? issuedDate;

  final String loaneeName;

  final bool defaulter;
  final String defaulterReason;
  final String status;

  LoanAccountEntity({
    required int id,
    required this.number,
    required this.type,
    required this.productCode,
    required this.moduleCode,
    required this.issuedAmount,
    required this.loanBalance,
    required this.refundAmount,
    required this.interestRate,
    required this.interestForDays,
    required this.numberOfInstallments,
    required this.loanEndDate,
    required this.lastPaidDate,
    required this.issuedDate,
    required this.loaneeName,
    required this.defaulter,
    required this.defaulterReason,
    required this.status,
  }) : super(id: id);

  @override
  List<Object?> get props => [
    id,
    number,
    type,
    productCode,
    moduleCode,
    issuedAmount,
    loanBalance,
    refundAmount,
    interestRate,
    interestForDays,
    numberOfInstallments,
    loanEndDate,
    lastPaidDate,
    issuedDate,
    loaneeName,
    defaulter,
    defaulterReason,
    status,
  ];
}
