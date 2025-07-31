part of 'beneficiaries_bloc.dart';

sealed class BeneficiariesEvent extends Equatable {
  const BeneficiariesEvent();

  @override
  List<Object> get props => [];
}

class FetchBeneficiaries extends BeneficiariesEvent {}

class DeleteBeneficiary extends BeneficiariesEvent {
  final String accountNumber;

  const DeleteBeneficiary(this.accountNumber);

  @override
  List<Object> get props => [accountNumber];
}
