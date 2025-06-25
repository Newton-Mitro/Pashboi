part of 'debit_card_bloc.dart';

sealed class DebitCardState extends Equatable {
  const DebitCardState();

  @override
  List<Object> get props => [];
}

final class DebitCardInitial extends DebitCardState {}

class DebitCardLoading extends DebitCardState {}

class DebitCardRequestProcessing extends DebitCardState {}

class DebitCardLoadingSuccess extends DebitCardState {
  final DebitCardEntity debitCard;
  const DebitCardLoadingSuccess(this.debitCard);
}

class DebitCardRequestSuccess extends DebitCardState {
  final String message;
  const DebitCardRequestSuccess(this.message);
}

class DebitCardError extends DebitCardState {
  final String error;
  const DebitCardError(this.error);
}
