part of 'account_opening_steps_bloc.dart';

class AccountOpeningStepsState extends Equatable {
  final int currentStep;
  final Map<int, Map<String, dynamic>> stepData;

  const AccountOpeningStepsState({
    required this.currentStep,
    required this.stepData,
  });

  AccountOpeningStepsState copyWith({
    int? currentStep,
    Map<int, Map<String, dynamic>>? stepData,
  }) {
    return AccountOpeningStepsState(
      currentStep: currentStep ?? this.currentStep,
      stepData: stepData ?? this.stepData,
    );
  }

  @override
  List<Object> get props => [currentStep, stepData];
}
