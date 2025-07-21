part of 'debit_card_bloc.dart';

class DebitCardState extends Equatable {
  final bool isLoading;
  final DebitCardEntity? debitCard;
  final String? successMessage;
  final String? error;

  const DebitCardState({
    this.isLoading = false,
    this.debitCard,
    this.successMessage,
    this.error,
  });

  DebitCardState copyWith({
    bool? isLoading,
    bool? isRequestProcessing,
    DebitCardEntity? debitCard,
    String? successMessage,
    String? error,
  }) {
    return DebitCardState(
      isLoading: isLoading ?? this.isLoading,
      debitCard: debitCard ?? this.debitCard,
      successMessage: successMessage,
      error: error,
    );
  }

  factory DebitCardState.initial() => const DebitCardState();

  @override
  List<Object?> get props => [isLoading, debitCard, successMessage, error];
}
