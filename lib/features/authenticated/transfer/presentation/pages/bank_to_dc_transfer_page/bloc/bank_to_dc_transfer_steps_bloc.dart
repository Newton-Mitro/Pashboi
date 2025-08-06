import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/entities/debit_card_entity.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_ledger_entity.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_now_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';
part 'bank_to_dc_transfer_setps_event.dart';
part 'bank_to_dc_transfer_steps_state.dart';

class BankToDcTransferStepsBloc
    extends Bloc<BankToDcTransferStepsEvent, BankToDcTransferStepsState> {
  // Define step range constants
  static const int firstStep = 0;
  static const int lastStep = 4;
  static const int totalSteps = lastStep + 1;
  final GetAuthUserUseCase getAuthUserUseCase;
  final SubmitDepositNowUseCase submitDepositNowUseCase;

  BankToDcTransferStepsBloc({
    required this.getAuthUserUseCase,
    required this.submitDepositNowUseCase,
  }) : super(const BankToDcTransferStepsState(currentStep: 0)) {
    on<BankToDcTransferGoToNextStep>(_onGoToNextStep);
    on<BankToDcTransferGoToPreviousStep>(_onGoToPreviousStep);
    on<BankToDcTransferUpdateStepData>(_onUpdateStepData);
    on<BankToDcTransferSetCollectionLedgers>(_onSetCollectionLedgers);
    on<BankToDcTransferToggleLedgerSelection>(_onToggleLedgerSelection);
    on<BankToDcTransferToggleSelectAllLedgers>(_onToggleSelectAllLedgers);
    on<BankToDcTransferUpdateLedgerAmount>(_onUpdateLedgerAmount);
    on<BankToDcTransferFlowReset>(_onResetFlow);
    on<BankToDcTransferSelectCardAccount>(_onSelectCardAccount);
    on<BankToDcTransferSelectDebitCard>(_onSelectDebitCard);
    // update lps amount
    on<BankToDcTransferUpdateLpsAmount>(_onUpdateLpsAmount);
    on<BankToDcTransferValidateStep>(_onValidateStep);
    on<BankToDcTransferSubmit>(_onSubmitDepositNow);
  }

  void _onGoToNextStep(
    BankToDcTransferGoToNextStep event,
    Emitter<BankToDcTransferStepsState> emit,
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
    BankToDcTransferGoToPreviousStep event,
    Emitter<BankToDcTransferStepsState> emit,
  ) {
    if (state.currentStep > firstStep) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void _onUpdateStepData(
    BankToDcTransferUpdateStepData event,
    Emitter<BankToDcTransferStepsState> emit,
  ) {
    final updatedStepData = Map<int, Map<String, dynamic>>.from(state.stepData);
    updatedStepData[event.step] = {
      ...?updatedStepData[event.step],
      ...event.data,
    };
    emit(state.copyWith(stepData: updatedStepData));
  }

  void _onSetCollectionLedgers(
    BankToDcTransferSetCollectionLedgers event,
    Emitter<BankToDcTransferStepsState> emit,
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
    BankToDcTransferToggleLedgerSelection event,
    Emitter<BankToDcTransferStepsState> emit,
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
    BankToDcTransferToggleSelectAllLedgers event,
    Emitter<BankToDcTransferStepsState> emit,
  ) {
    final updatedLedgers =
        state.collectionLedgers
            .map((l) => l.copyWith(isSelected: event.selectAll))
            .toList();

    emit(state.copyWith(collectionLedgers: updatedLedgers));
  }

  void _onUpdateLedgerAmount(
    BankToDcTransferUpdateLedgerAmount event,
    Emitter<BankToDcTransferStepsState> emit,
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
    BankToDcTransferFlowReset event,
    Emitter<BankToDcTransferStepsState> emit,
  ) {
    emit(const BankToDcTransferStepsState(currentStep: 0));
  }

  void _onSelectCardAccount(
    BankToDcTransferSelectCardAccount event,
    Emitter<BankToDcTransferStepsState> emit,
  ) {
    emit(state.copyWith(selectedAccount: event.selectedCardAccount));
  }

  void _onSelectDebitCard(
    BankToDcTransferSelectDebitCard event,
    Emitter<BankToDcTransferStepsState> emit,
  ) {
    emit(state.copyWith(selectedCard: event.selectedCard));
  }

  void _onUpdateLpsAmount(
    BankToDcTransferUpdateLpsAmount event,
    Emitter<BankToDcTransferStepsState> emit,
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
    BankToDcTransferValidateStep event,
    Emitter<BankToDcTransferStepsState> emit,
  ) {
    final step = event.step;

    final errors = _validateDepositNowSteps(step);
    final updatedValidationErrors = Map<int, Map<String, dynamic>>.from(
      state.validationErrors,
    );

    updatedValidationErrors[step] = errors;

    emit(state.copyWith(validationErrors: updatedValidationErrors));
  }

  void _onSubmitDepositNow(
    BankToDcTransferSubmit event,
    Emitter<BankToDcTransferStepsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final authUserResult = await getAuthUserUseCase.call(NoParams());

      if (authUserResult.isLeft()) {
        emit(state.copyWith(error: 'User not found', isLoading: false));
        return;
      }

      final user = authUserResult.getOrElse(() => throw Exception()).user;

      final totalAmount = state.collectionLedgers
          .where((ledger) => ledger.isSelected)
          .fold<double>(0.0, (sum, ledger) => sum + ledger.depositAmount);

      final accountResult = await submitDepositNowUseCase.call(
        SubmitDepositNowProps(
          email: user.loginEmail,
          userId: user.userId,
          rolePermissionId: user.roleId,
          personId: user.personId,
          employeeCode: user.employeeCode,
          mobileNumber: user.regMobile,
          accountNumber: state.selectedAccount!.number,
          accountHolderName:
              state.selectedCard!.nameOnCard.toLowerCase().trim(),
          accountId: state.selectedAccount!.id,
          accountType: state.selectedAccount!.typeName,
          cardNumber: state.selectedCard!.cardNumber,
          depositDate: DateTime.now().toIso8601String(),
          ledgerId: state.selectedAccount!.ledgerId,
          cardPin:
              md5
                  .convert(utf8.encode(state.stepData[4]?['cardPin'].trim()))
                  .toString(),
          totalDepositAmount: totalAmount,
          transactionMethod: '12',
          otpRegId: state.stepData[4]?['OTPRegId'],
          otpValue: state.stepData[5]?['OTP'],
          transactionType: 'DepositRequest',
          collectionLedgers: state.collectionLedgers,
        ),
      );

      accountResult.fold(
        (failure) =>
            emit(state.copyWith(error: failure.message, isLoading: false)),
        (message) =>
            emit(state.copyWith(successMessage: message, isLoading: false)),
      );
    } catch (_) {
      emit(
        state.copyWith(error: 'Failed to submit deposit now', isLoading: false),
      );
    }
  }

  Map<String, dynamic> _validateDepositNowSteps(int step) {
    final data = state.stepData[step] ?? {};
    final errors = <String, dynamic>{};

    switch (step) {
      case 0:
        // if (state.selectedAccount == null ||
        //     state.selectedAccount!.number.isEmpty) {
        //   errors['transferFromAccount'] = 'Select an account to transfer from';
        // }
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

            final totalWithdrawable =
                state.selectedAccount != null
                    ? state.selectedAccount!.withdrawableBalance
                    : 0;

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
