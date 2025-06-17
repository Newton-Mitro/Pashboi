import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'account_opening_setps_event.dart';
part 'account_opening_steps_state.dart';

class AccountOpeningStepsBloc
    extends Bloc<AccountOpeningStepsEvent, AccountOpeningStepsState> {
  AccountOpeningStepsBloc()
    : super(AccountOpeningStepsState(currentStep: 0, stepData: {})) {
    on<GoToNextStep>((event, emit) {
      if (state.currentStep < 2) {
        emit(state.copyWith(currentStep: state.currentStep + 1));
      }
    });

    on<GoToPreviousStep>((event, emit) {
      if (state.currentStep > 0) {
        emit(state.copyWith(currentStep: state.currentStep - 1));
      }
    });

    on<JumpToStep>((event, emit) {
      emit(state.copyWith(currentStep: event.step));
    });

    on<UpdateStepData>((event, emit) {
      final newData = Map<int, Map<String, dynamic>>.from(state.stepData);
      newData[event.step] = {
        ...(newData[event.step] ?? {}),
        event.key: event.value,
      };
      emit(state.copyWith(stepData: newData));
    });
  }
}
