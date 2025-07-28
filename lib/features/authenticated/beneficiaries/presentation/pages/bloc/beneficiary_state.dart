part of 'beneficiary_bloc.dart';

class BeneficiaryState extends Equatable {
  final bool isLoading;
  final List<BeneficiaryEntity> beneficiaries;
  final String? error;
  final Map<String, String>? errors;

  const BeneficiaryState({
    this.isLoading = false,
    this.beneficiaries = const [],
    this.error,
    this.errors,
  });

  BeneficiaryState copyWith({
    bool? isLoading,
    List<BeneficiaryEntity>? beneficiaries,
    String? error,
    final Map<String, String>? errors,
  }) {
    return BeneficiaryState(
      isLoading: isLoading ?? this.isLoading,
      beneficiaries: beneficiaries ?? this.beneficiaries,
      error: error,
      errors: errors,
    );
  }

  @override
  List<Object?> get props => [isLoading, beneficiaries, error, errors];
}
