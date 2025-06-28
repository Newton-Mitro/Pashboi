import 'package:pashboi/core/entities/entity.dart';

class CollateralAccountEntity extends Entity<int> {
  final int accountId;
  final String accountNumber;
  final String accountType;
  final double balance;
  final double loanableBalance;
  final double withdrawableBalance;
  final double pertialApplyLoanAmount;
  final bool isEligible;

  CollateralAccountEntity({
    required int id,
    required this.accountId,
    required this.accountNumber,
    required this.accountType,
    required this.balance,
    required this.loanableBalance,
    required this.withdrawableBalance,
    required this.pertialApplyLoanAmount,
    required this.isEligible,
  }) : super(id: id);

  @override
  List<Object?> get props => [
    id,
    accountId,
    accountNumber,
    accountType,
    balance,
    loanableBalance,
    withdrawableBalance,
    pertialApplyLoanAmount,
    isEligible,
  ];
}
