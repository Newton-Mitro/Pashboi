import 'package:pashboi/core/entities/entity.dart';

class EligibleLoanProductEntity extends Entity<int> {
  final int productId;
  final String loanProductCode;
  final String loanProductName;
  final int interestRate;
  final bool isEligible;

  EligibleLoanProductEntity({
    required int id,
    required this.productId,
    required this.loanProductCode,
    required this.loanProductName,
    required this.interestRate,
    required this.isEligible,
  }) : super(id: id);

  @override
  List<Object?> get props => [
    id,
    loanProductCode,
    loanProductName,
    interestRate,
    isEligible,
  ];
}
