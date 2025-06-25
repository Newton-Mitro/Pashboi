import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/nominee_entity.dart';

part 'account_opening_setps_event.dart';
part 'account_opening_steps_state.dart';

class AccountOpeningStepsBloc
    extends Bloc<AccountOpeningStepsEvent, AccountOpeningStepsState> {
  // Define step range constants
  static const int firstStep = 0;
  static const int lastStep = 5;
  static const int totalSteps = lastStep + 1;

  AccountOpeningStepsBloc()
    : super(const AccountOpeningStepsState(currentStep: 0, stepData: {})) {
    on<GoToNextStep>(_onGoToNextStep);
    on<GoToPreviousStep>(_onGoToPreviousStep);
    on<UpdateStepData>(_onUpdateStepData);
    on<AddNominee>(_onAddNominee);
    on<RemoveNominee>(_onRemoveNominee);
  }

  void _onGoToNextStep(
    GoToNextStep event,
    Emitter<AccountOpeningStepsState> emit,
  ) {
    if (state.currentStep < lastStep) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void _onGoToPreviousStep(
    GoToPreviousStep event,
    Emitter<AccountOpeningStepsState> emit,
  ) {
    if (state.currentStep > firstStep) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void _onUpdateStepData(
    UpdateStepData event,
    Emitter<AccountOpeningStepsState> emit,
  ) {
    final updatedStepData = Map<int, Map<String, dynamic>>.from(state.stepData);
    final currentStepData = updatedStepData[event.step] ?? {};

    updatedStepData[event.step] = {...currentStepData, event.key: event.value};

    emit(state.copyWith(stepData: updatedStepData));
  }

  void _onAddNominee(AddNominee event, Emitter<AccountOpeningStepsState> emit) {
    final updatedStepData = Map<int, Map<String, dynamic>>.from(state.stepData);
    final currentStepData = updatedStepData[event.step] ?? {};

    final existingNominees = List<NomineeEntity>.from(
      currentStepData['selectedNominees'] ?? [],
    );
    existingNominees.add(event.nominee);

    updatedStepData[event.step] = {
      ...currentStepData,
      'selectedNominees': existingNominees,
    };

    emit(state.copyWith(stepData: updatedStepData));
  }

  void _onRemoveNominee(
    RemoveNominee event,
    Emitter<AccountOpeningStepsState> emit,
  ) {
    final updatedStepData = Map<int, Map<String, dynamic>>.from(state.stepData);
    final currentStepData = updatedStepData[event.step] ?? {};

    final existingNominees = List<NomineeEntity>.from(
      currentStepData['selectedNominees'] ?? [],
    );
    existingNominees.removeWhere((n) => n.id == event.nominee.id);

    updatedStepData[event.step] = {
      ...currentStepData,
      'selectedNominees': existingNominees,
    };

    emit(state.copyWith(stepData: updatedStepData));
  }
}
