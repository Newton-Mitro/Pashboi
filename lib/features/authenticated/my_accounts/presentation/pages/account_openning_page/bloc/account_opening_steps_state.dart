part of 'account_opening_steps_bloc.dart';

class AccountOpeningStepsState extends Equatable {
  final int currentStep;

  const AccountOpeningStepsState({required this.currentStep});

  AccountOpeningStepsState copyWith({
    int? currentStep,
    Map<int, Map<String, dynamic>>? stepData,
  }) {
    return AccountOpeningStepsState(
      currentStep: currentStep ?? this.currentStep,
    );
  }

  @override
  List<Object> get props => [currentStep];
}
