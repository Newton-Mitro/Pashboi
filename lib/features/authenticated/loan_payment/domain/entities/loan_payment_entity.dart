import 'package:pashboi/core/entities/entity.dart';

class LoanPaymentEntity extends Entity<int> {
  final String loanNumber;
  final double loanRefundAmount;
  final double interestAmount;
  final double loanFineAmount;
  final double loanLpsAmount;
  final double loanLpsRenewalFeeAmount;
  final double shareFineAmount;

  LoanPaymentEntity({
    super.id,
    required this.loanNumber,
    required this.loanRefundAmount,
    required this.interestAmount,
    required this.loanFineAmount,
    required this.loanLpsAmount,
    required this.loanLpsRenewalFeeAmount,
    required this.shareFineAmount,
  });

  @override
  List<Object?> get props => [
    id,
    loanNumber,
    loanRefundAmount,
    interestAmount,
    loanFineAmount,
    loanLpsAmount,
    loanLpsRenewalFeeAmount,
    shareFineAmount,
  ];
}
