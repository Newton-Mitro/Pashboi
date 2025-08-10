part of 'internal_transfer_steps_bloc.dart';

abstract class InternalTransferStepsEvent extends Equatable {
  const InternalTransferStepsEvent();

  @override
  List<Object> get props => [];
}

class InternalTransferGoToNextStep extends InternalTransferStepsEvent {}

class InternalTransferValidateStep extends InternalTransferStepsEvent {
  final int step;

  const InternalTransferValidateStep(this.step);

  @override
  List<Object> get props => [step];
}

class InternalTransferGoToPreviousStep extends InternalTransferStepsEvent {}

class InternalTransferUpdateStepData extends InternalTransferStepsEvent {
  final int step;
  final Map<String, dynamic> data;

  const InternalTransferUpdateStepData({
    required this.step,
    required this.data,
  });

  @override
  List<Object> get props => [step, data];
}

class InternalTransferSetCollectionLedgers extends InternalTransferStepsEvent {
  final List<CollectionLedgerEntity> ledgers;

  const InternalTransferSetCollectionLedgers({required this.ledgers});

  @override
  List<Object> get props => [ledgers];
}

class InternalTransferToggleLedgerSelection extends InternalTransferStepsEvent {
  final CollectionLedgerEntity ledger;

  const InternalTransferToggleLedgerSelection(this.ledger);

  @override
  List<Object> get props => [ledger];
}

class InternalTransferToggleSelectAllLedgers
    extends InternalTransferStepsEvent {
  final bool selectAll;

  const InternalTransferToggleSelectAllLedgers(this.selectAll);

  @override
  List<Object> get props => [selectAll];
}

class InternalTransferUpdateLedgerAmount extends InternalTransferStepsEvent {
  final CollectionLedgerEntity ledger;
  final double newAmount;

  const InternalTransferUpdateLedgerAmount({
    required this.ledger,
    required this.newAmount,
  });

  @override
  List<Object> get props => [ledger, newAmount];
}

class InternalTransferUpdateLpsAmount extends InternalTransferStepsEvent {
  final String loanNumber;
  final double newAmount;

  const InternalTransferUpdateLpsAmount({
    required this.loanNumber,
    required this.newAmount,
  });

  @override
  List<Object> get props => [loanNumber, newAmount];
}

class InternalTransferSelectCardAccount extends InternalTransferStepsEvent {
  final DepositAccountEntity selectedCardAccount;

  const InternalTransferSelectCardAccount(this.selectedCardAccount);

  @override
  List<Object> get props => [selectedCardAccount];
}

class InternalTransferSelectDebitCard extends InternalTransferStepsEvent {
  final DebitCardEntity selectedCard;

  const InternalTransferSelectDebitCard(this.selectedCard);

  @override
  List<Object> get props => [selectedCard];
}

class InternalTransferFlowReset extends InternalTransferStepsEvent {}

class InternalTransferSubmit extends InternalTransferStepsEvent {
  final String toAccountNumber;
  final double transferAmount;

  const InternalTransferSubmit({
    required this.toAccountNumber,
    required this.transferAmount,
  });

  @override
  List<Object> get props => [toAccountNumber, transferAmount];
}
