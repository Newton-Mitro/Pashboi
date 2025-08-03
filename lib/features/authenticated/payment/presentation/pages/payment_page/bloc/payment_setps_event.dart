part of 'payment_steps_bloc.dart';

abstract class PaymentStepsEvent extends Equatable {
  const PaymentStepsEvent();

  @override
  List<Object> get props => [];
}

class PaymentGoToNextStep extends PaymentStepsEvent {}

class PaymentValidateStep extends PaymentStepsEvent {
  final int step;

  const PaymentValidateStep(this.step);

  @override
  List<Object> get props => [step];
}

class PaymentGoToPreviousStep extends PaymentStepsEvent {}

class PaymentUpdateStepData extends PaymentStepsEvent {
  final int step;
  final Map<String, dynamic> data;

  const PaymentUpdateStepData({required this.step, required this.data});

  @override
  List<Object> get props => [step, data];
}

class PaymentSetCollectionLedgers extends PaymentStepsEvent {
  final List<CollectionLedgerEntity> ledgers;

  const PaymentSetCollectionLedgers({required this.ledgers});

  @override
  List<Object> get props => [ledgers];
}

class PaymentToggleLedgerSelection extends PaymentStepsEvent {
  final CollectionLedgerEntity ledger;

  const PaymentToggleLedgerSelection(this.ledger);

  @override
  List<Object> get props => [ledger];
}

class PaymentToggleSelectAllLedgers extends PaymentStepsEvent {
  final bool selectAll;

  const PaymentToggleSelectAllLedgers(this.selectAll);

  @override
  List<Object> get props => [selectAll];
}

class PaymentUpdateLedgerAmount extends PaymentStepsEvent {
  final CollectionLedgerEntity ledger;
  final double newAmount;

  const PaymentUpdateLedgerAmount({
    required this.ledger,
    required this.newAmount,
  });

  @override
  List<Object> get props => [ledger, newAmount];
}

class PaymentUpdateLpsAmount extends PaymentStepsEvent {
  final String loanNumber;
  final double newAmount;

  const PaymentUpdateLpsAmount({
    required this.loanNumber,
    required this.newAmount,
  });

  @override
  List<Object> get props => [loanNumber, newAmount];
}

class PaymentSelectCardAccount extends PaymentStepsEvent {
  final DepositAccountEntity selectedCardAccount;

  const PaymentSelectCardAccount(this.selectedCardAccount);

  @override
  List<Object> get props => [selectedCardAccount];
}

class PaymentSelectDebitCard extends PaymentStepsEvent {
  final DebitCardEntity selectedCard;

  const PaymentSelectDebitCard(this.selectedCard);

  @override
  List<Object> get props => [selectedCard];
}

class PaymentFlowReset extends PaymentStepsEvent {}

class PaymentSubmit extends PaymentStepsEvent {}
