part of 'beneficiaries_bloc.dart';

sealed class BeneficiariesEvent extends Equatable {
  const BeneficiariesEvent();

  @override
  List<Object> get props => [];
}

class FetchBeneficiaries extends BeneficiariesEvent {}

class CreateBeneficiary extends BeneficiariesEvent {
  final String accountNumber;
  final String beneficiaryName;

  const CreateBeneficiary({
    required this.accountNumber,
    required this.beneficiaryName,
  });

  @override
  List<Object> get props => [accountNumber, beneficiaryName];
}

class DeleteBeneficiary extends BeneficiariesEvent {
  final String accountNumber;

  const DeleteBeneficiary(this.accountNumber);

  @override
  List<Object> get props => [accountNumber];
}
