part of 'deposit_now_steps_bloc.dart';

abstract class DepositNowStepsEvent extends Equatable {
  const DepositNowStepsEvent();

  @override
  List<Object> get props => [];
}

class DepositNowGoToNextStep extends DepositNowStepsEvent {}

class DepositNowGoToPreviousStep extends DepositNowStepsEvent {}
