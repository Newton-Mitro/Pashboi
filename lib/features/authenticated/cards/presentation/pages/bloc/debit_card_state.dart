part of 'debit_card_bloc.dart';

class DebitCardState extends Equatable {
  final bool isLoading;
  final DebitCardEntity? debitCard;
  final String? successMessage;
  final String? error;
  final int pinAttempts;

  const DebitCardState({
    this.isLoading = false,
    this.debitCard,
    this.successMessage,
    this.error,
    this.pinAttempts = 0,
  });

  DebitCardState copyWith({
    bool? isLoading,
    bool? isRequestProcessing,
    DebitCardEntity? debitCard,
    String? successMessage,
    String? error,
    int? pinAttempts,
  }) {
    return DebitCardState(
      isLoading: isLoading ?? this.isLoading,
      debitCard: debitCard ?? this.debitCard,
      successMessage: successMessage,
      error: error,
      pinAttempts: pinAttempts ?? this.pinAttempts,
    );
  }

  factory DebitCardState.initial() => const DebitCardState();

  @override
  List<Object?> get props => [
    isLoading,
    debitCard,
    successMessage,
    error,
    pinAttempts,
  ];
}
