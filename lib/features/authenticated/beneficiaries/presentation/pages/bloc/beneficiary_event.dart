part of 'beneficiary_bloc.dart';

sealed class BeneficiaryEvent extends Equatable {
  const BeneficiaryEvent();

  @override
  List<Object> get props => [];
}

class FetchBeneficiaries extends BeneficiaryEvent {}

class CreateBeneficiary extends BeneficiaryEvent {
  final String accountNumber;
  final String beneficiaryName;

  const CreateBeneficiary({
    required this.accountNumber,
    required this.beneficiaryName,
  });

  @override
  List<Object> get props => [accountNumber, beneficiaryName];
}

class DeleteBeneficiary extends BeneficiaryEvent {
  final String accountNumber;

  const DeleteBeneficiary(this.accountNumber);

  @override
  List<Object> get props => [accountNumber];
}
