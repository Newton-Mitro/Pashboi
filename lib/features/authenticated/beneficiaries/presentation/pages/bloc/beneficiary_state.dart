part of 'beneficiary_bloc.dart';

sealed class BeneficiaryState extends Equatable {
  const BeneficiaryState();

  @override
  List<Object> get props => [];
}

final class BeneficiaryInitial extends BeneficiaryState {}

class BeneficiaryLoading extends BeneficiaryState {}

class BeneficiaryLoaded extends BeneficiaryState {
  final List<BeneficiaryEntity> beneficiaries;

  const BeneficiaryLoaded(this.beneficiaries);

  @override
  List<Object> get props => [beneficiaries];
}

class BeneficiaryError extends BeneficiaryState {
  final String error;

  const BeneficiaryError(this.error);

  @override
  List<Object> get props => [error];
}
