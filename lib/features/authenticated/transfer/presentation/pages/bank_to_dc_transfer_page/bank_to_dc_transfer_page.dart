import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/features/authenticated/beneficiaries/presentation/pages/beneficiaries_bloc/beneficiaries_bloc.dart';
import 'package:pashboi/features/authenticated/cards/presentation/pages/bloc/debit_card_bloc.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_ledger_entity.dart';
import 'package:pashboi/features/authenticated/transfer/presentation/pages/bank_to_dc_transfer_page/sections/bank_transfer_info_section/bank_transfer_info_section.dart';
import 'package:pashboi/features/authenticated/authenticated_shared/widgets/transaction_details_section/transaction_details_section.dart';
import 'package:pashboi/features/authenticated/deposit/presentation/pages/deposit_now_page/parts/transaction_preview_section/transaction_preview_section.dart';
import 'package:pashboi/features/authenticated/transfer/presentation/pages/bank_to_dc_transfer_page/bloc/bank_to_dc_transfer_steps_bloc.dart';
import 'package:progress_stepper/progress_stepper.dart';

import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/authenticated_shared/widgets/card_pin_verification_section/card_pin_verification_section.dart';
import 'package:pashboi/features/authenticated/authenticated_shared/widgets/otp_verification_section/otp_verification_section.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';
import 'package:pashboi/shared/widgets/step_item.dart';

class BankToDcTransferPage extends StatefulWidget {
  const BankToDcTransferPage({super.key});

  @override
  State<BankToDcTransferPage> createState() => _BankToDcTransferPageState();
}

class _BankToDcTransferPageState extends State<BankToDcTransferPage> {
  Widget _buildProgressStepper(double width, BankToDcTransferStepsState state) {
    final theme = context.theme.colorScheme;

    return ProgressStepper(
      width: width * 0.9,
      padding: 5,
      height: 50,
      color: theme.primary,
      stepCount: BankToDcTransferStepsBloc.totalSteps,
      bluntHead: false,
      bluntTail: false,
      currentStep: state.currentStep,
      builder: (context, index, stepWidth) {
        final isCompleted = index - 1 <= state.currentStep;
        return ProgressStepWithChevron(
          width: stepWidth,
          height: 50,
          defaultColor: theme.surface,
          progressColor: theme.primary,
          borderColor: theme.primary,
          borderWidth: 2,
          wasCompleted: isCompleted,
          child: Center(
            child: Icon(
              _buildSteps(state)[index - 1].icon,
              color:
                  isCompleted
                      ? theme.onPrimary
                      : theme.onSurface.withAlpha(220),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return MultiBlocListener(
      listeners: [
        BlocListener<DebitCardBloc, DebitCardState>(
          listener: (context, state) {
            if (state.successMessage != null) {
              context.read<BankToDcTransferStepsBloc>().add(
                BankToDcTransferUpdateStepData(
                  step: 4,
                  data: {'OTPRegId': state.successMessage},
                ),
              );
              context.read<BankToDcTransferStepsBloc>().add(
                BankToDcTransferGoToNextStep(),
              );
            }
            if (state.error != null) {
              final snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Oops!',
                  message: state.error!,
                  contentType: ContentType.failure,
                ),
              );

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            }
          },
        ),
        BlocListener<BankToDcTransferStepsBloc, BankToDcTransferStepsState>(
          listener: (context, state) {
            if (state.error != null) {
              final snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Oops!',
                  message: state.error!,
                  contentType: ContentType.failure,
                ),
              );

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            }

            if (state.successMessage != null) {
              Navigator.of(context).pop();
              final snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Oops!',
                  message: state.successMessage!,
                  contentType: ContentType.success,
                ),
              );

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            }
          },
        ),
      ],

      child: BlocBuilder<BankToDcTransferStepsBloc, BankToDcTransferStepsState>(
        builder: (context, depositLaterStepsState) {
          final isFirstStep =
              depositLaterStepsState.currentStep ==
              BankToDcTransferStepsBloc.firstStep;
          final isLastStep =
              depositLaterStepsState.currentStep ==
              BankToDcTransferStepsBloc.lastStep;

          return Scaffold(
            appBar: AppBar(title: const Text('Bank To DC Transfer Request')),
            body: Stack(
              children: [
                PageContainer(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 15,
                        ),
                        child: _buildProgressStepper(
                          width,
                          depositLaterStepsState,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (child, animation) => SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(1, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                            child: KeyedSubtree(
                              key: ValueKey(depositLaterStepsState.currentStep),
                              child:
                                  _buildSteps(
                                    depositLaterStepsState,
                                  )[depositLaterStepsState.currentStep].widget,
                            ),
                          ),
                        ),
                      ),
                      SafeArea(
                        maintainBottomViewPadding: true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              isFirstStep
                                  ? const SizedBox(width: 100)
                                  : AppPrimaryButton(
                                    horizontalPadding: 10,
                                    iconBefore: const Icon(
                                      FontAwesomeIcons.angleLeft,
                                    ),
                                    label: "Previous",
                                    onPressed: () {
                                      context
                                          .read<BankToDcTransferStepsBloc>()
                                          .add(
                                            BankToDcTransferGoToPreviousStep(),
                                          );
                                    },
                                  ),
                              isLastStep
                                  ? const SizedBox(width: 100)
                                  : AppPrimaryButton(
                                    horizontalPadding: 10,
                                    iconAfter: const Icon(
                                      FontAwesomeIcons.angleRight,
                                    ),
                                    label: "Next",
                                    onPressed: () {
                                      if (depositLaterStepsState.currentStep ==
                                          4) {
                                        context
                                            .read<BankToDcTransferStepsBloc>()
                                            .add(
                                              BankToDcTransferValidateStep(4),
                                            );
                                        _verifyCardPIN(depositLaterStepsState);
                                        return;
                                      }
                                      context
                                          .read<BankToDcTransferStepsBloc>()
                                          .add(BankToDcTransferGoToNextStep());
                                    },
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<DebitCardBloc, DebitCardState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return Container(
                        color: Colors.black.withOpacity(0.4),
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    } else if (state.error != null) {
                      return const SizedBox.shrink();
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
            bottomNavigationBar:
                isLastStep ? _buildSubmitButton(width, context) : null,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<BeneficiariesBloc>().add(FetchBeneficiaries());
  }

  void _verifyCardPIN(BankToDcTransferStepsState depositLaterStepsState) {
    context.read<DebitCardBloc>().add(
      DebitCardPinVerify(
        accountNumber: depositLaterStepsState.selectedAccount!.number,
        cardNumber: depositLaterStepsState.selectedCard!.cardNumber,
        nameOnCard:
            depositLaterStepsState.selectedCard!.nameOnCard
                .toLowerCase()
                .trim(),
        cardPIN:
            depositLaterStepsState.stepData[depositLaterStepsState
                .currentStep]?['cardPin'],
      ),
    );
  }

  List<StepItem> _buildSteps(BankToDcTransferStepsState state) {
    final selectedLedgers = state.collectionLedgers;
    return [
      StepItem(
        icon: FontAwesomeIcons.moneyBillTransfer,
        widget: BankTransferInfoSection(
          searchedAccountHolderName: '',
          sectionTitle: 'Proof of Bank Transfer',
          setCollectionLedgers:
              (List<CollectionLedgerEntity> collectionLedgers) {},
          changeSearchAccountNumber: (String? accountNumber) {},
          onChangeSearchAccountNumber: (String? accountNumber) {},
          changeBeneficiaryAccountNumber: (String? beneficiaryAccountNumber) {},
          changeSearchedAccountHolderName: (String? accountHolderName) {},
        ),
      ),

      StepItem(
        icon: FontAwesomeIcons.piggyBank,
        widget: TransactionDetailsSection(
          ledgers: selectedLedgers,
          onToggleSelect: (ledger) {
            context.read<BankToDcTransferStepsBloc>().add(
              BankToDcTransferToggleLedgerSelection(ledger),
            );
          },
          onToggleSelectAll: (selectAll) {
            context.read<BankToDcTransferStepsBloc>().add(
              BankToDcTransferToggleSelectAllLedgers(selectAll),
            );
          },
          onAmountChanged: (ledger, newAmount) {
            context.read<BankToDcTransferStepsBloc>().add(
              BankToDcTransferUpdateLedgerAmount(
                ledger: ledger,
                newAmount: newAmount,
              ),
            );
          },
          sectionError: state.validationErrors[state.currentStep]?['ledgers'],
          amountErrors: state.validationErrors[state.currentStep]?['amounts'],
        ),
      ),

      StepItem(
        icon: FontAwesomeIcons.eye,
        widget: TransactionPreviewSection(collectionLedgers: selectedLedgers),
      ),
      StepItem(
        icon: FontAwesomeIcons.creditCard,
        widget: CardPinVerificationSection(
          cardNumber: state.selectedCard?.cardNumber,
          cardNumberError: state.validationErrors[0]?['selectedCardNumber'],
          cardPin: state.stepData[state.currentStep]?['cardPin'],
          cardPinError: state.validationErrors[state.currentStep]?['cardPin'],
          onCardPinChanged: (pin) {
            context.read<BankToDcTransferStepsBloc>().add(
              BankToDcTransferUpdateStepData(
                step: state.currentStep,
                data: {'cardPin': pin},
              ),
            );
          },
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.key,
        widget: OtpVerificationSection(
          resendOTP: () {
            _verifyCardPIN(state);
          },
          onOtpChanged: (String otp) {
            context.read<BankToDcTransferStepsBloc>().add(
              BankToDcTransferUpdateStepData(
                step: state.currentStep,
                data: {'OTP': otp},
              ),
            );
          },
          otp: state.stepData[state.currentStep]?['OTP'] ?? '',
        ),
      ),
    ];
  }

  Widget _buildSubmitButton(double width, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: BlocBuilder<BankToDcTransferStepsBloc, BankToDcTransferStepsState>(
        builder: (context, state) {
          return ProgressSubmitButton(
            width: width - 10,
            height: 100,
            enabled: !state.isLoading,
            backgroundColor: context.theme.colorScheme.primary,
            progressColor: context.theme.colorScheme.secondary,
            foregroundColor: context.theme.colorScheme.onPrimary,
            label: 'Hold & Press to Submit',
            onSubmit: () {
              _submitBankToDcTransfer(state);
            },
          );
        },
      ),
    );
  }

  void _submitBankToDcTransfer(BankToDcTransferStepsState state) {
    context.read<BankToDcTransferStepsBloc>().add(BankToDcTransferSubmit());
  }
}
