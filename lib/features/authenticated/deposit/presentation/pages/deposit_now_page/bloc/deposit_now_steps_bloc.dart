import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'deposit_now_setps_event.dart';
part 'deposit_now_steps_state.dart';

class DepositNowStepsBloc
    extends Bloc<DepositNowStepsEvent, DepositNowStepsState> {
  // Define step range constants
  static const int firstStep = 0;
  static const int lastStep = 5;
  static const int totalSteps = lastStep + 1;

  DepositNowStepsBloc() : super(const DepositNowStepsState(currentStep: 0)) {
    on<DepositNowGoToNextStep>(_onGoToNextStep);
    on<DepositNowGoToPreviousStep>(_onGoToPreviousStep);
  }

  void _onGoToNextStep(
    DepositNowGoToNextStep event,
    Emitter<DepositNowStepsState> emit,
  ) {
    if (state.currentStep < lastStep) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void _onGoToPreviousStep(
    DepositNowGoToPreviousStep event,
    Emitter<DepositNowStepsState> emit,
  ) {
    if (state.currentStep > firstStep) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }
}
