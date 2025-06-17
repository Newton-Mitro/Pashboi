part of 'debit_card_bloc.dart';

sealed class DebitCardState extends Equatable {
  const DebitCardState();

  @override
  List<Object> get props => [];
}

final class DebitCardInitial extends DebitCardState {}

class DebitCardLoading extends DebitCardState {}

class DebitCardLoaded extends DebitCardState {
  final DebitCardEntity debitCard;
  const DebitCardLoaded(this.debitCard);
}

class DebitCardError extends DebitCardState {
  final String message;
  const DebitCardError(this.message);
}
