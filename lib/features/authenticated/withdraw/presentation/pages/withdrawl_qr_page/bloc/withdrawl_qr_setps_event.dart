part of 'withdrawl_qr_steps_bloc.dart';

abstract class WithdrawlQrStepsEvent extends Equatable {
  const WithdrawlQrStepsEvent();

  @override
  List<Object> get props => [];
}

class WithdrawlQrGoToNextStep extends WithdrawlQrStepsEvent {}

class WithdrawlQrValidateStep extends WithdrawlQrStepsEvent {
  final int step;

  const WithdrawlQrValidateStep(this.step);

  @override
  List<Object> get props => [step];
}

class WithdrawlQrGoToPreviousStep extends WithdrawlQrStepsEvent {}

class WithdrawlQrUpdateStepData extends WithdrawlQrStepsEvent {
  final int step;
  final Map<String, dynamic> data;

  const WithdrawlQrUpdateStepData({required this.step, required this.data});

  @override
  List<Object> get props => [step, data];
}

class WithdrawlQrSetCollectionLedgers extends WithdrawlQrStepsEvent {
  final List<CollectionLedgerEntity> ledgers;

  const WithdrawlQrSetCollectionLedgers({required this.ledgers});

  @override
  List<Object> get props => [ledgers];
}

class WithdrawlQrToggleLedgerSelection extends WithdrawlQrStepsEvent {
  final CollectionLedgerEntity ledger;

  const WithdrawlQrToggleLedgerSelection(this.ledger);

  @override
  List<Object> get props => [ledger];
}

class WithdrawlQrToggleSelectAllLedgers extends WithdrawlQrStepsEvent {
  final bool selectAll;

  const WithdrawlQrToggleSelectAllLedgers(this.selectAll);

  @override
  List<Object> get props => [selectAll];
}

class WithdrawlQrUpdateLedgerAmount extends WithdrawlQrStepsEvent {
  final CollectionLedgerEntity ledger;
  final double newAmount;

  const WithdrawlQrUpdateLedgerAmount({
    required this.ledger,
    required this.newAmount,
  });

  @override
  List<Object> get props => [ledger, newAmount];
}

class WithdrawlQrUpdateLpsAmount extends WithdrawlQrStepsEvent {
  final String loanNumber;
  final double newAmount;

  const WithdrawlQrUpdateLpsAmount({
    required this.loanNumber,
    required this.newAmount,
  });

  @override
  List<Object> get props => [loanNumber, newAmount];
}

class WithdrawlQrSelectCardAccount extends WithdrawlQrStepsEvent {
  final DepositAccountEntity selectedCardAccount;

  const WithdrawlQrSelectCardAccount(this.selectedCardAccount);

  @override
  List<Object> get props => [selectedCardAccount];
}

class WithdrawlQrSelectDebitCard extends WithdrawlQrStepsEvent {
  final DebitCardEntity selectedCard;

  const WithdrawlQrSelectDebitCard(this.selectedCard);

  @override
  List<Object> get props => [selectedCard];
}

class WithdrawlQrFlowReset extends WithdrawlQrStepsEvent {}

class WithdrawlQrSubmit extends WithdrawlQrStepsEvent {
  final double withdrawAmount;

  const WithdrawlQrSubmit(this.withdrawAmount);

  @override
  List<Object> get props => [withdrawAmount];
}
