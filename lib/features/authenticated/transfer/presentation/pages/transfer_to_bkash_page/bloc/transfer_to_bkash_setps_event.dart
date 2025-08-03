part of 'transfer_to_bkash_steps_bloc.dart';

abstract class TransferToBkashStepsEvent extends Equatable {
  const TransferToBkashStepsEvent();

  @override
  List<Object> get props => [];
}

class TransferToBkashGoToNextStep extends TransferToBkashStepsEvent {}

class TransferToBkashValidateStep extends TransferToBkashStepsEvent {
  final int step;

  const TransferToBkashValidateStep(this.step);

  @override
  List<Object> get props => [step];
}

class TransferToBkashGoToPreviousStep extends TransferToBkashStepsEvent {}

class TransferToBkashUpdateStepData extends TransferToBkashStepsEvent {
  final int step;
  final Map<String, dynamic> data;

  const TransferToBkashUpdateStepData({required this.step, required this.data});

  @override
  List<Object> get props => [step, data];
}

class TransferToBkashSetCollectionLedgers extends TransferToBkashStepsEvent {
  final List<CollectionLedgerEntity> ledgers;

  const TransferToBkashSetCollectionLedgers({required this.ledgers});

  @override
  List<Object> get props => [ledgers];
}

class TransferToBkashToggleLedgerSelection extends TransferToBkashStepsEvent {
  final CollectionLedgerEntity ledger;

  const TransferToBkashToggleLedgerSelection(this.ledger);

  @override
  List<Object> get props => [ledger];
}

class TransferToBkashToggleSelectAllLedgers extends TransferToBkashStepsEvent {
  final bool selectAll;

  const TransferToBkashToggleSelectAllLedgers(this.selectAll);

  @override
  List<Object> get props => [selectAll];
}

class TransferToBkashUpdateLedgerAmount extends TransferToBkashStepsEvent {
  final CollectionLedgerEntity ledger;
  final double newAmount;

  const TransferToBkashUpdateLedgerAmount({
    required this.ledger,
    required this.newAmount,
  });

  @override
  List<Object> get props => [ledger, newAmount];
}

class TransferToBkashUpdateLpsAmount extends TransferToBkashStepsEvent {
  final String loanNumber;
  final double newAmount;

  const TransferToBkashUpdateLpsAmount({
    required this.loanNumber,
    required this.newAmount,
  });

  @override
  List<Object> get props => [loanNumber, newAmount];
}

class TransferToBkashSelectCardAccount extends TransferToBkashStepsEvent {
  final DepositAccountEntity selectedCardAccount;

  const TransferToBkashSelectCardAccount(this.selectedCardAccount);

  @override
  List<Object> get props => [selectedCardAccount];
}

class TransferToBkashSelectDebitCard extends TransferToBkashStepsEvent {
  final DebitCardEntity selectedCard;

  const TransferToBkashSelectDebitCard(this.selectedCard);

  @override
  List<Object> get props => [selectedCard];
}

class TransferToBkashFlowReset extends TransferToBkashStepsEvent {}

class TransferToBkashSubmit extends TransferToBkashStepsEvent {}
