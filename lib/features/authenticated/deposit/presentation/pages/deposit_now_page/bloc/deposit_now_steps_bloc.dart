import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_ledger_entity.dart';
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
    on<UpdateStepData>(_onUpdateStepData);
    on<SetCollectionLedgers>(_onSetCollectionLedgers);
    on<ToggleLedgerSelection>(_onToggleLedgerSelection);
    on<ToggleSelectAllLedgers>(_onToggleSelectAllLedgers);
    on<UpdateLedgerAmount>(_onUpdateLedgerAmount);
    on<ResetDepositNowFlow>(_onResetFlow);
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

  void _onUpdateStepData(
    UpdateStepData event,
    Emitter<DepositNowStepsState> emit,
  ) {
    final updatedStepData = Map<int, Map<String, dynamic>>.from(state.stepData);
    updatedStepData[event.step] = {
      ...?updatedStepData[event.step],
      ...event.data,
    };
    emit(state.copyWith(stepData: updatedStepData));
  }

  void _onSetCollectionLedgers(
    SetCollectionLedgers event,
    Emitter<DepositNowStepsState> emit,
  ) {
    final selectedLedgers =
        event.ledgers
            .map(
              (ledger) => ledger.copyWith(
                depositAmount: ledger.amount,
                isSelected: false,
              ),
            )
            .toList();
    emit(state.copyWith(collectionLedgers: selectedLedgers));
  }

  void _onToggleLedgerSelection(
    ToggleLedgerSelection event,
    Emitter<DepositNowStepsState> emit,
  ) {
    final updatedLedgers =
        state.collectionLedgers.map((l) {
          if (l.accountId == event.ledger.accountId &&
              l.accountNumber == event.ledger.accountNumber &&
              l.ledgerId == event.ledger.ledgerId) {
            return l.copyWith(isSelected: !(l.isSelected));
          }
          return l;
        }).toList();

    emit(state.copyWith(collectionLedgers: updatedLedgers));
  }

  void _onToggleSelectAllLedgers(
    ToggleSelectAllLedgers event,
    Emitter<DepositNowStepsState> emit,
  ) {
    final updatedLedgers =
        state.collectionLedgers
            .map((l) => l.copyWith(isSelected: event.selectAll))
            .toList();

    emit(state.copyWith(collectionLedgers: updatedLedgers));
  }

  void _onUpdateLedgerAmount(
    UpdateLedgerAmount event,
    Emitter<DepositNowStepsState> emit,
  ) {
    final updatedLedgers =
        state.collectionLedgers.map((l) {
          if (l.accountId == event.ledger.accountId &&
              l.accountNumber == event.ledger.accountNumber &&
              l.ledgerId == event.ledger.ledgerId) {
            return l.copyWith(depositAmount: event.newAmount);
          }
          return l;
        }).toList();

    emit(state.copyWith(collectionLedgers: updatedLedgers));
  }

  void _onResetFlow(
    ResetDepositNowFlow event,
    Emitter<DepositNowStepsState> emit,
  ) {
    emit(const DepositNowStepsState(currentStep: 0));
  }
}
