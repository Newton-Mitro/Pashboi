part of 'deposit_from_bkash_steps_bloc.dart';

class DepositFromBkashStepsState extends Equatable {
  final int currentStep;
  final Map<int, Map<String, dynamic>> validationErrors;
  final Map<int, Map<String, dynamic>> stepData;
  final List<CollectionLedgerEntity> collectionLedgers;
  final bool isLoading;
  final String? error;
  final String? successMessage;

  const DepositFromBkashStepsState({
    required this.currentStep,
    Map<int, Map<String, dynamic>>? validationErrors,
    Map<int, Map<String, dynamic>>? stepData,
    List<CollectionLedgerEntity>? collectionLedgers,
    bool? isLoading,
    this.error,
    this.successMessage,
  }) : validationErrors = validationErrors ?? const {},
       stepData = stepData ?? const {},
       isLoading = isLoading ?? false,
       collectionLedgers = collectionLedgers ?? const [];

  DepositFromBkashStepsState copyWith({
    int? currentStep,
    Map<int, Map<String, dynamic>>? validationErrors,
    Map<int, Map<String, dynamic>>? stepData,
    List<CollectionLedgerEntity>? collectionLedgers,
    bool? isLoading,
    String? error,
    String? successMessage,
  }) {
    return DepositFromBkashStepsState(
      currentStep: currentStep ?? this.currentStep,
      validationErrors: validationErrors ?? this.validationErrors,
      stepData: stepData ?? this.stepData,
      collectionLedgers: collectionLedgers ?? this.collectionLedgers,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [
    currentStep,
    validationErrors,
    stepData,
    collectionLedgers,
    isLoading,
    error,
    successMessage,
  ];
}
