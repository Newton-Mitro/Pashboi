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
    // update lps amount
    on<UpdateLpsAmount>(_onUpdateLpsAmount);
    on<DepositNowValidateStep>(_onValidateStep);
  }

  void _onGoToNextStep(
    DepositNowGoToNextStep event,
    Emitter<DepositNowStepsState> emit,
  ) {
    final step = state.currentStep;
    final errors = _validateDepositNowSteps(step);

    final updatedValidationErrors = Map<int, Map<String, dynamic>>.from(
      state.validationErrors,
    );
    updatedValidationErrors[step] = errors;

    if (errors.isEmpty && step < lastStep) {
      emit(
        state.copyWith(
          currentStep: step + 1,
          validationErrors: updatedValidationErrors,
        ),
      );
    } else {
      emit(state.copyWith(validationErrors: updatedValidationErrors));
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
    late List<CollectionLedgerEntity> updatedLedgers;

    if (event.ledger.subledger) {
      updatedLedgers =
          state.collectionLedgers.map((l) {
            if (l.accountNumber == event.ledger.accountNumber) {
              return l.copyWith(isSelected: !(event.ledger.isSelected));
            }
            return l;
          }).toList();
    } else if (event.ledger.plType == 2 || event.ledger.plType == 1) {
      updatedLedgers =
          state.collectionLedgers.map((l) {
            if (l.accountNumber == event.ledger.accountNumber &&
                !event.ledger.isSelected) {
              return l.copyWith(isSelected: true);
            } else if (l.accountNumber == event.ledger.accountNumber &&
                event.ledger.ledgerId == l.ledgerId) {
              return l.copyWith(isSelected: false);
            }
            return l;
          }).toList();
    } else {
      updatedLedgers =
          state.collectionLedgers.map((l) {
            if (l.accountId == event.ledger.accountId &&
                l.accountNumber == event.ledger.accountNumber &&
                l.ledgerId == event.ledger.ledgerId) {
              return l.copyWith(isSelected: !(l.isSelected));
            }
            return l;
          }).toList();
    }

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
    if (!event.ledger.subledger &&
        event.ledger.plType == 2 &&
        event.ledger.lps) {
      return;
    }
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

  void _onUpdateLpsAmount(
    UpdateLpsAmount event,
    Emitter<DepositNowStepsState> emit,
  ) {
    final updatedLedgers =
        state.collectionLedgers.map((l) {
          if (l.collectionType.trim() == 'LoanLpsAmount' &&
              l.accountNumber == event.loanNumber) {
            return l.copyWith(depositAmount: event.newAmount);
          }
          return l;
        }).toList();

    emit(state.copyWith(collectionLedgers: updatedLedgers));
  }

  void _onValidateStep(
    DepositNowValidateStep event,
    Emitter<DepositNowStepsState> emit,
  ) {
    final step = event.step ?? state.currentStep;

    final errors = _validateDepositNowSteps(step);
    final updatedValidationErrors = Map<int, Map<String, dynamic>>.from(
      state.validationErrors,
    );

    updatedValidationErrors[step] = errors;

    emit(state.copyWith(validationErrors: updatedValidationErrors));
  }

  Map<String, dynamic> _validateDepositNowSteps(int step) {
    final data = state.stepData[step] ?? {};
    final errors = <String, dynamic>{};

    switch (step) {
      case 0:
        if (data['transferFromAccount'] == null ||
            data['transferFromAccount'].toString().isEmpty) {
          errors['transferFromAccount'] = 'Select an account to transfer from';
        }
        break;

      case 1:
        if (data['searchAccountNumber'] == null) {
          errors['searchAccountNumber'] =
              'Please enter a search account number';
        }
        if (data['searchedAccountHolderName'] == null) {
          errors['searchedAccountHolderName'] =
              'Search account holder name is required';
        }
        break;

      case 2:
        final selectedLedgers =
            state.collectionLedgers.where((l) => l.isSelected).toList();
        if (selectedLedgers.isEmpty) {
          errors['ledgers'] = 'Please select at least one ledger to deposit';
        } else {
          // Map ledgerId to error message for invalid deposit amounts
          final Map<String, String> amountErrors = {};

          for (final ledger in selectedLedgers) {
            if (ledger.depositAmount <= 0) {
              amountErrors[ledger.ledgerId.toString()] =
                  'Deposit amount must be greater than zero';
            } else if (!ledger.subledger &&
                ledger.depositAmount < ledger.amount) {
              amountErrors[ledger.ledgerId.toString()] =
                  'Deposit amount cannot be less than the ${ledger.amount}';
            } else if (ledger.multiplier &&
                ledger.depositAmount % ledger.amount != 0) {
              amountErrors[ledger.ledgerId.toString()] =
                  'Deposit amount must be a multiple of ${ledger.amount}';
            } else if (ledger.plType == 2 &&
                ledger.depositAmount > ledger.loanBalance) {
              amountErrors[ledger.ledgerId.toString()] =
                  'Deposit amount cannot be greater than the ${ledger.loanBalance}';
            }
          }

          if (amountErrors.isNotEmpty) {
            errors['amounts'] = amountErrors;
          } else {
            final totalDeposit = selectedLedgers.fold<double>(
              0,
              (sum, ledger) => sum + (ledger.depositAmount),
            );

            final totalWithdrawable = double.parse(
              state.stepData[0]?['accountWithdrawable'] ?? '0',
            );

            if (totalDeposit > totalWithdrawable) {
              errors['ledgers'] =
                  "You don't have enough balance to deposit this amount";
            }
          }
        }
        break;

      case 4:
        if (data['cardPin'] == null || data['cardPin'].toString().isEmpty) {
          errors['cardPin'] = 'Please enter a card PIN';
        } else if (data['cardPin'].length != 4) {
          errors['cardPin'] = 'PIN must be 4 digits';
        }
        break;

      case 5:
        if (data['confirmation'] != true) {
          errors['confirmation'] = 'You must confirm to proceed';
        }
        break;

      // No validation needed for final review/step 5
      default:
        break;
    }

    return errors;
  }
}
