import 'package:pashboi/core/entities/entity.dart';

class SuretyEntity extends Entity<int> {
  final String loanNumber;
  final DateTime? loanOpenDate;
  final String suretyAccountNumber;
  final String accountHolderName;
  final String mobileNumber;
  final String collateralType;
  final double loanAmount;
  final double suretyAmount;
  final double loanBalance;
  final double suretyReleaseAmount;
  final DateTime? loanEndDate;
  final DateTime? lastPaidDate;
  final bool defaulter;
  final String defaulterReason;
  final String status;

  SuretyEntity({
    required int id,
    required this.loanNumber,
    required this.loanOpenDate,
    required this.suretyAccountNumber,
    required this.accountHolderName,
    required this.mobileNumber,
    required this.collateralType,
    required this.loanAmount,
    required this.suretyAmount,
    required this.loanBalance,
    required this.suretyReleaseAmount,
    required this.loanEndDate,
    required this.lastPaidDate,
    required this.defaulter,
    required this.defaulterReason,
    required this.status,
  }) : super(id: id);

  @override
  List<Object?> get props => [
    id,
    loanNumber,
    loanOpenDate,
    suretyAccountNumber,
    accountHolderName,
    mobileNumber,
    collateralType,
    loanAmount,
    suretyAmount,
    loanBalance,
    suretyReleaseAmount,
    loanEndDate,
    lastPaidDate,
    defaulter,
    defaulterReason,
    status,
  ];
}
