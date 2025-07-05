part of 'beneficiary_bloc.dart';

class BeneficiaryState extends Equatable {
  final bool isLoading;
  final List<BeneficiaryEntity> beneficiaries;
  final String? error;

  const BeneficiaryState({
    this.isLoading = false,
    this.beneficiaries = const [],
    this.error,
  });

  BeneficiaryState copyWith({
    bool? isLoading,
    List<BeneficiaryEntity>? beneficiaries,
    String? error,
  }) {
    return BeneficiaryState(
      isLoading: isLoading ?? this.isLoading,
      beneficiaries: beneficiaries ?? this.beneficiaries,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, beneficiaries, error];
}
