part of 'debit_card_bloc.dart';

sealed class DebitCardEvent extends Equatable {
  const DebitCardEvent();

  @override
  List<Object> get props => [];
}

class DebitCardLoad extends DebitCardEvent {
  const DebitCardLoad();
}

class DebitCardIssue extends DebitCardEvent {
  const DebitCardIssue();
}

class DebitCardReIssue extends DebitCardEvent {
  const DebitCardReIssue();
}

class DebitCardBlock extends DebitCardEvent {
  const DebitCardBlock();
}

class DebitCardPinVerify extends DebitCardEvent {
  const DebitCardPinVerify();
}
