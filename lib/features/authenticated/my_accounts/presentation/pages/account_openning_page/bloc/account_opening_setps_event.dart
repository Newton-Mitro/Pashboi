part of 'account_opening_steps_bloc.dart';

abstract class AccountOpeningStepsEvent extends Equatable {
  const AccountOpeningStepsEvent();

  @override
  List<Object> get props => [];
}

class AccountOpeningGoToNextStep extends AccountOpeningStepsEvent {}

class AccountOpeningValidateStep extends AccountOpeningStepsEvent {
  final int step;

  const AccountOpeningValidateStep(this.step);

  @override
  List<Object> get props => [step];
}

class AccountOpeningGoToPreviousStep extends AccountOpeningStepsEvent {}

class AccountOpeningUpdateStepData extends AccountOpeningStepsEvent {
  final int step;
  final Map<String, dynamic> data;

  const AccountOpeningUpdateStepData({required this.step, required this.data});

  @override
  List<Object> get props => [step, data];
}

class AccountOpeningSetCollectionLedgers extends AccountOpeningStepsEvent {
  final List<CollectionLedgerEntity> ledgers;

  const AccountOpeningSetCollectionLedgers({required this.ledgers});

  @override
  List<Object> get props => [ledgers];
}

class AccountOpeningToggleLedgerSelection extends AccountOpeningStepsEvent {
  final CollectionLedgerEntity ledger;

  const AccountOpeningToggleLedgerSelection(this.ledger);

  @override
  List<Object> get props => [ledger];
}

class AccountOpeningToggleSelectAllLedgers extends AccountOpeningStepsEvent {
  final bool selectAll;

  const AccountOpeningToggleSelectAllLedgers(this.selectAll);

  @override
  List<Object> get props => [selectAll];
}

class AccountOpeningUpdateLedgerAmount extends AccountOpeningStepsEvent {
  final CollectionLedgerEntity ledger;
  final double newAmount;

  const AccountOpeningUpdateLedgerAmount({
    required this.ledger,
    required this.newAmount,
  });

  @override
  List<Object> get props => [ledger, newAmount];
}

class AccountOpeningUpdateLpsAmount extends AccountOpeningStepsEvent {
  final String loanNumber;
  final double newAmount;

  const AccountOpeningUpdateLpsAmount({
    required this.loanNumber,
    required this.newAmount,
  });

  @override
  List<Object> get props => [loanNumber, newAmount];
}

class AccountOpeningSelectCardAccount extends AccountOpeningStepsEvent {
  final DepositAccountEntity selectedCardAccount;

  const AccountOpeningSelectCardAccount(this.selectedCardAccount);

  @override
  List<Object> get props => [selectedCardAccount];
}

class AccountOpeningSelectDebitCard extends AccountOpeningStepsEvent {
  final DebitCardEntity selectedCard;

  const AccountOpeningSelectDebitCard(this.selectedCard);

  @override
  List<Object> get props => [selectedCard];
}

class AccountOpeningFlowReset extends AccountOpeningStepsEvent {}

class AccountOpeningSubmit extends AccountOpeningStepsEvent {}
