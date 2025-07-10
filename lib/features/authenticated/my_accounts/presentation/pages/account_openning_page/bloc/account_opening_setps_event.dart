part of 'account_opening_steps_bloc.dart';

abstract class AccountOpeningStepsEvent extends Equatable {
  const AccountOpeningStepsEvent();

  @override
  List<Object> get props => [];
}

class GoToNextStep extends AccountOpeningStepsEvent {}

class GoToPreviousStep extends AccountOpeningStepsEvent {}
