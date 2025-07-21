part of 'deposit_now_steps_bloc.dart';

class DepositNowStepsState extends Equatable {
  final int currentStep;
  final Map<int, Map<String, dynamic>> validationErrors;
  final Map<int, Map<String, dynamic>> stepData;
  final List<CollectionLedgerEntity> collectionLedgers;
  final bool isLoading;

  const DepositNowStepsState({
    required this.currentStep,
    Map<int, Map<String, dynamic>>? validationErrors,
    Map<int, Map<String, dynamic>>? stepData,
    List<CollectionLedgerEntity>? collectionLedgers,
    bool? isLoading,
  }) : validationErrors = validationErrors ?? const {},
       stepData = stepData ?? const {},
       isLoading = isLoading ?? false,
       collectionLedgers = collectionLedgers ?? const [];

  DepositNowStepsState copyWith({
    int? currentStep,
    Map<int, Map<String, dynamic>>? validationErrors,
    Map<int, Map<String, dynamic>>? stepData,
    List<CollectionLedgerEntity>? collectionLedgers,
    bool? isLoading,
  }) {
    return DepositNowStepsState(
      currentStep: currentStep ?? this.currentStep,
      validationErrors: validationErrors ?? this.validationErrors,
      stepData: stepData ?? this.stepData,
      collectionLedgers: collectionLedgers ?? this.collectionLedgers,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    currentStep,
    validationErrors,
    stepData,
    collectionLedgers,
    isLoading,
  ];
}
