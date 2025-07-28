part of 'account_opening_steps_bloc.dart';

class AccountOpeningStepsState extends Equatable {
  final int currentStep;
  final Map<int, Map<String, dynamic>> validationErrors;
  final Map<int, Map<String, dynamic>> stepData;
  final List<NomineeEntity> nominees;
  final DepositAccountEntity? selectedAccount;
  final DebitCardEntity? selectedCard;
  final TenureEntity? selectedTenure;
  final TenureAmountEntity? selectedTenureAmount;
  final bool isLoading;
  final String? error;
  final String? successMessage;

  const AccountOpeningStepsState({
    required this.currentStep,
    this.selectedAccount,
    this.selectedCard,
    this.selectedTenure,
    this.selectedTenureAmount,
    Map<int, Map<String, dynamic>>? validationErrors,
    Map<int, Map<String, dynamic>>? stepData,
    List<NomineeEntity>? nominees,
    bool? isLoading,
    this.error,
    this.successMessage,
  }) : validationErrors = validationErrors ?? const {},
       stepData = stepData ?? const {},
       isLoading = isLoading ?? false,
       nominees = nominees ?? const [];

  AccountOpeningStepsState copyWith({
    int? currentStep,
    Map<int, Map<String, dynamic>>? validationErrors,
    Map<int, Map<String, dynamic>>? stepData,
    List<NomineeEntity>? nominees,
    DepositAccountEntity? selectedAccount,
    DebitCardEntity? selectedCard,
    TenureEntity? selectedTenure,
    TenureAmountEntity? selectedTenureAmount,
    bool? isLoading,
    String? error,
    String? successMessage,
  }) {
    return AccountOpeningStepsState(
      currentStep: currentStep ?? this.currentStep,
      validationErrors: validationErrors ?? this.validationErrors,
      stepData: stepData ?? this.stepData,
      nominees: nominees ?? this.nominees,
      selectedAccount: selectedAccount ?? this.selectedAccount,
      selectedCard: selectedCard ?? this.selectedCard,
      selectedTenure: selectedTenure ?? this.selectedTenure,
      selectedTenureAmount: selectedTenureAmount ?? this.selectedTenureAmount,
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
    nominees,
    selectedAccount,
    selectedCard,
    selectedTenure,
    selectedTenureAmount,
    isLoading,
    error,
    successMessage,
  ];
}
