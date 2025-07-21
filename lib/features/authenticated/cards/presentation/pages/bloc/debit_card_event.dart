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
  final String cardTypeCode;
  final bool withCard;

  const DebitCardIssue({required this.cardTypeCode, required this.withCard});
}

class DebitCardReIssue extends DebitCardEvent {
  final String cardNumber;
  final String cardTypeCode;
  final bool virtualCard;
  final String nameOnCard;

  const DebitCardReIssue({
    required this.cardNumber,
    required this.cardTypeCode,
    required this.virtualCard,
    required this.nameOnCard,
  });
}

class DebitCardBlock extends DebitCardEvent {
  final String cardNumber;
  final String accountNumber;
  final String nameOnCard;

  const DebitCardBlock({
    required this.cardNumber,
    required this.accountNumber,
    required this.nameOnCard,
  });
}

class DebitCardPinVerify extends DebitCardEvent {
  final String cardNumber;
  final String nameOnCard;
  final String cardPIN;
  final String accountNumber;

  const DebitCardPinVerify({
    required this.cardNumber,
    required this.nameOnCard,
    required this.cardPIN,
    required this.accountNumber,
  });
}
