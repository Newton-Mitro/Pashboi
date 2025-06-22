part of 'account_opening_steps_bloc.dart';

abstract class AccountOpeningStepsEvent extends Equatable {
  const AccountOpeningStepsEvent();

  @override
  List<Object> get props => [];
}

class GoToNextStep extends AccountOpeningStepsEvent {}

class GoToPreviousStep extends AccountOpeningStepsEvent {}

class UpdateStepData extends AccountOpeningStepsEvent {
  final int step;
  final String key;
  final dynamic value;

  const UpdateStepData({
    required this.step,
    required this.key,
    required this.value,
  });

  @override
  List<Object> get props => [step, key, value];
}
