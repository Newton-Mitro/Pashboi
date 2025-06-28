import 'package:pashboi/core/entities/entity.dart';

class LoanAccountEntity extends Entity<int> {
  final String number;

  final String typeName;
  final String shortTypeName;
  final String productCode;
  final String moduleCode;

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
    required this.typeName,
    this.shortTypeName = '',
    this.productCode = '',
    this.moduleCode = '',
    this.issuedAmount = 0.0,
    required this.loanBalance,
    this.refundAmount = 0.0,
    this.interestRate = 0.0,
    this.interestForDays = 0,
    this.numberOfInstallments = '',
    this.loanEndDate,
    this.lastPaidDate,
    this.issuedDate,
    this.loaneeName = '',
    this.defaulter = false,
    this.defaulterReason = 'Regular',
    this.status = 'Active',
  }) : super(id: id);

  @override
  List<Object?> get props => [
    id,
    number,
    typeName,
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
