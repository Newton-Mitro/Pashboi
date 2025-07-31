part of 'beneficiaries_bloc.dart';

abstract class BeneficiariesState extends Equatable {
  const BeneficiariesState();

  @override
  List<Object?> get props => [];
}

class BeneficiariesInitial extends BeneficiariesState {
  const BeneficiariesInitial();
}

class BeneficiariesLoading extends BeneficiariesState {
  const BeneficiariesLoading();
}

class BeneficiariesLoaded extends BeneficiariesState {
  final List<BeneficiaryEntity> beneficiaries;

  const BeneficiariesLoaded(this.beneficiaries);

  @override
  List<Object?> get props => [beneficiaries];
}

class BeneficiariesSuccess extends BeneficiariesState {
  const BeneficiariesSuccess();
}

class BeneficiariesError extends BeneficiariesState {
  final String message;

  const BeneficiariesError(this.message);

  @override
  List<Object?> get props => [message];
}
