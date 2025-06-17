part of 'debit_card_bloc.dart';

sealed class DebitCardEvent extends Equatable {
  const DebitCardEvent();

  @override
  List<Object> get props => [];
}

class LoadMyDebitCard extends DebitCardEvent {
  const LoadMyDebitCard();
}

class IssueDebitCard extends DebitCardEvent {
  const IssueDebitCard();
}

class ReIssueDebitCard extends DebitCardEvent {
  const ReIssueDebitCard();
}

class BlocDebitCard extends DebitCardEvent {
  const BlocDebitCard();
}

class VerifyCardPIN extends DebitCardEvent {
  const VerifyCardPIN();
}
