part of 'deposit_now_steps_bloc.dart';

class DepositNowStepsState extends Equatable {
  final int currentStep;

  const DepositNowStepsState({required this.currentStep});

  DepositNowStepsState copyWith({
    int? currentStep,
    Map<int, Map<String, dynamic>>? stepData,
  }) {
    return DepositNowStepsState(currentStep: currentStep ?? this.currentStep);
  }

  @override
  List<Object> get props => [currentStep];
}
