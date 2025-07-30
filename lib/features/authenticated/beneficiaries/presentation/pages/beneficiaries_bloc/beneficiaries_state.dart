part of 'beneficiaries_bloc.dart';

class BeneficiariesState extends Equatable {
  final bool isLoading;
  final List<BeneficiaryEntity> beneficiaries;
  final String? error;
  final Map<String, String>? errors;

  const BeneficiariesState({
    this.isLoading = false,
    this.beneficiaries = const [],
    this.error,
    this.errors,
  });

  BeneficiariesState copyWith({
    bool? isLoading,
    List<BeneficiaryEntity>? beneficiaries,
    String? error,
    final Map<String, String>? errors,
  }) {
    return BeneficiariesState(
      isLoading: isLoading ?? this.isLoading,
      beneficiaries: beneficiaries ?? this.beneficiaries,
      error: error,
      errors: errors,
    );
  }

  @override
  List<Object?> get props => [isLoading, beneficiaries, error, errors];
}
