part of 'bank_to_dc_transfer_steps_bloc.dart';

class BankToDcTransferStepsState extends Equatable {
  final int currentStep;
  final Map<int, Map<String, dynamic>> validationErrors;
  final Map<int, Map<String, dynamic>> stepData;
  final List<CollectionLedgerEntity> collectionLedgers;
  final DepositAccountEntity? selectedAccount;
  final DebitCardEntity? selectedCard;
  final DcBankEntity selectedBankAccount;
  final bool isLoading;
  final String? error;
  final String? successMessage;

  const BankToDcTransferStepsState({
    required this.currentStep,
    required this.selectedAccount,
    required this.selectedBankAccount,
    required this.selectedCard,
    required this.validationErrors,
    required this.stepData,
    required this.collectionLedgers,
    required this.isLoading,
    required this.error,
    required this.successMessage,
  });

  BankToDcTransferStepsState copyWith({
    int? currentStep,
    Map<int, Map<String, dynamic>>? validationErrors,
    Map<int, Map<String, dynamic>>? stepData,
    List<CollectionLedgerEntity>? collectionLedgers,
    DepositAccountEntity? selectedAccount,
    DebitCardEntity? selectedCard,
    DcBankEntity? selectedBankAccount,
    bool? isLoading,
    String? error,
    String? successMessage,
  }) {
    return BankToDcTransferStepsState(
      currentStep: currentStep ?? this.currentStep,
      validationErrors: validationErrors ?? this.validationErrors,
      stepData: stepData ?? this.stepData,
      collectionLedgers: collectionLedgers ?? this.collectionLedgers,
      selectedAccount: selectedAccount ?? this.selectedAccount,
      selectedCard: selectedCard ?? this.selectedCard,
      selectedBankAccount: selectedBankAccount ?? this.selectedBankAccount,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
    currentStep,
    validationErrors,
    stepData,
    collectionLedgers,
    selectedAccount,
    selectedCard,
    selectedBankAccount,
    isLoading,
    error,
    successMessage,
  ];
}
