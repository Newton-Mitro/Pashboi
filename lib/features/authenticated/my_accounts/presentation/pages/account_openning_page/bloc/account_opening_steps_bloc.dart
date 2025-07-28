import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/entities/debit_card_entity.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_ledger_entity.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_now_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/nominee_entity.dart';
part 'account_opening_setps_event.dart';
part 'account_opening_steps_state.dart';

class AccountOpeningStepsBloc
    extends Bloc<AccountOpeningStepsEvent, AccountOpeningStepsState> {
  // Define step range constants
  static const int firstStep = 0;
  static const int lastStep = 5;
  static const int totalSteps = lastStep + 1;
  final GetAuthUserUseCase getAuthUserUseCase;
  final SubmitDepositNowUseCase submitDepositNowUseCase;

  AccountOpeningStepsBloc({
    required this.getAuthUserUseCase,
    required this.submitDepositNowUseCase,
  }) : super(const AccountOpeningStepsState(currentStep: 0)) {
    on<AccountOpeningGoToNextStep>(_onGoToNextStep);
    on<AccountOpeningGoToPreviousStep>(_onGoToPreviousStep);
    on<AccountOpeningUpdateStepData>(_onUpdateStepData);
    on<AccountOpeningFlowReset>(_onResetFlow);
    on<AccountOpeningSelectCardAccount>(_onSelectCardAccount);
    on<AccountOpeningSelectDebitCard>(_onSelectDebitCard);
    // update lps amount
    on<AccountOpeningValidateStep>(_onValidateStep);
    // on<AccountOpeningSubmit>(_onSubmitOpenAnAccount);
  }

  void _onGoToNextStep(
    AccountOpeningGoToNextStep event,
    Emitter<AccountOpeningStepsState> emit,
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
    AccountOpeningGoToPreviousStep event,
    Emitter<AccountOpeningStepsState> emit,
  ) {
    if (state.currentStep > firstStep) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void _onUpdateStepData(
    AccountOpeningUpdateStepData event,
    Emitter<AccountOpeningStepsState> emit,
  ) {
    final updatedStepData = Map<int, Map<String, dynamic>>.from(state.stepData);
    updatedStepData[event.step] = {
      ...?updatedStepData[event.step],
      ...event.data,
    };
    emit(state.copyWith(stepData: updatedStepData));
  }

  void _onResetFlow(
    AccountOpeningFlowReset event,
    Emitter<AccountOpeningStepsState> emit,
  ) {
    emit(const AccountOpeningStepsState(currentStep: 0));
  }

  void _onSelectCardAccount(
    AccountOpeningSelectCardAccount event,
    Emitter<AccountOpeningStepsState> emit,
  ) {
    emit(state.copyWith(selectedAccount: event.selectedCardAccount));
  }

  void _onSelectDebitCard(
    AccountOpeningSelectDebitCard event,
    Emitter<AccountOpeningStepsState> emit,
  ) {
    emit(state.copyWith(selectedCard: event.selectedCard));
  }

  void _onValidateStep(
    AccountOpeningValidateStep event,
    Emitter<AccountOpeningStepsState> emit,
  ) {
    final step = event.step;

    final errors = _validateDepositNowSteps(step);
    final updatedValidationErrors = Map<int, Map<String, dynamic>>.from(
      state.validationErrors,
    );

    updatedValidationErrors[step] = errors;

    emit(state.copyWith(validationErrors: updatedValidationErrors));
  }

  void _onSubmitOpenAnAccount() {}

  Map<String, dynamic> _validateDepositNowSteps(int step) {
    final data = state.stepData[step] ?? {};
    final errors = <String, dynamic>{};

    switch (step) {
      case 0:
        if (state.selectedAccount == null ||
            state.selectedAccount!.number.isEmpty) {
          errors['transferFromAccount'] = 'Select an account to transfer from';
        }
        break;

      case 1:
        // if (data['searchAccountNumber'] == null) {
        //   errors['searchAccountNumber'] =
        //       'Please enter a search account number';
        // }
        // if (data['searchedAccountHolderName'] == null) {
        //   errors['searchedAccountHolderName'] =
        //       'Search account holder name is required';
        // }
        break;

      case 2:
        // final selectedLedgers =
        //     state.nominees.where((l) => l.isSelected).toList();
        // if (selectedLedgers.isEmpty) {
        //   errors['ledgers'] = 'Please select at least one ledger to deposit';
        // } else {
        //   // Map ledgerId to error message for invalid deposit amounts
        //   final Map<String, String> amountErrors = {};

        //   for (final ledger in selectedLedgers) {
        //     if (ledger.depositAmount <= 0) {
        //       amountErrors[ledger.ledgerId.toString()] =
        //           'Deposit amount must be greater than zero';
        //     } else if (!ledger.subledger &&
        //         ledger.depositAmount < ledger.amount) {
        //       amountErrors[ledger.ledgerId.toString()] =
        //           'Deposit amount cannot be less than the ${ledger.amount}';
        //     } else if (ledger.multiplier &&
        //         ledger.depositAmount % ledger.amount != 0) {
        //       amountErrors[ledger.ledgerId.toString()] =
        //           'Deposit amount must be a multiple of ${ledger.amount}';
        //     } else if (ledger.plType == 2 &&
        //         ledger.depositAmount > ledger.loanBalance) {
        //       amountErrors[ledger.ledgerId.toString()] =
        //           'Deposit amount cannot be greater than the ${ledger.loanBalance}';
        //     }
        //   }

        //   if (amountErrors.isNotEmpty) {
        //     errors['amounts'] = amountErrors;
        //   } else {
        //     final totalDeposit = selectedLedgers.fold<double>(
        //       0,
        //       (sum, ledger) => sum + (ledger.depositAmount),
        //     );

        //     final totalWithdrawable =
        //         state.selectedAccount != null
        //             ? state.selectedAccount!.withdrawableBalance
        //             : 0;

        //     if (totalDeposit > totalWithdrawable) {
        //       errors['ledgers'] =
        //           "You don't have enough balance to deposit this amount";
        //     }
        //   }
        // }
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
