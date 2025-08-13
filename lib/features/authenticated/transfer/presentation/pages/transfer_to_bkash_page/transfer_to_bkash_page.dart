import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/string_casing_extension.dart';
import 'package:pashboi/features/authenticated/beneficiaries/presentation/pages/beneficiaries_bloc/beneficiaries_bloc.dart';
import 'package:pashboi/features/authenticated/cards/presentation/pages/bloc/debit_card_bloc.dart';
import 'package:pashboi/features/authenticated/transfer/presentation/pages/transfer_to_bkash_page/parts/transfer_amount_section/transfer_amount_section.dart';
import 'package:pashboi/features/authenticated/transfer/presentation/pages/transfer_to_bkash_page/parts/transfer_preview_section/transfer_preview_section.dart';
import 'package:pashboi/features/authenticated/transfer/presentation/pages/transfer_to_bkash_page/parts/transfer_to_mobile_section/transfer_to_mobile_section.dart';
import 'package:pashboi/features/authenticated/transfer/presentation/pages/transfer_to_bkash_page/bloc/transfer_to_bkash_steps_bloc.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:progress_stepper/progress_stepper.dart';

import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/authenticated_shared/widgets/card_pin_verification_section/card_pin_verification_section.dart';
import 'package:pashboi/features/authenticated/authenticated_shared/widgets/otp_verification_section/otp_verification_section.dart';
import 'package:pashboi/features/authenticated/authenticated_shared/widgets/transfer_from_section/transfer_from_section.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';
import 'package:pashboi/shared/widgets/step_item.dart';

class TransferToBkashPage extends StatefulWidget {
  const TransferToBkashPage({super.key});

  @override
  State<TransferToBkashPage> createState() => _TransferToBkashPageState();
}

class _TransferToBkashPageState extends State<TransferToBkashPage> {
  Widget _buildProgressStepper(double width, TransferToBkashStepsState state) {
    final theme = context.theme.colorScheme;

    return ProgressStepper(
      width: width * 0.9,
      padding: 5,
      height: 50,
      color: theme.primary,
      stepCount: TransferToBkashStepsBloc.totalSteps,
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
              context.read<TransferToBkashStepsBloc>().add(
                TransferToBkashUpdateStepData(
                  step: 4,
                  data: {'OTPRegId': state.successMessage},
                ),
              );
              context.read<TransferToBkashStepsBloc>().add(
                TransferToBkashGoToNextStep(),
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
        BlocListener<TransferToBkashStepsBloc, TransferToBkashStepsState>(
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
              Navigator.pushReplacementNamed(
                context,
                AuthRoutesName.transferToBkashSuccessPage,
                arguments: {'message': state.successMessage},
              );
            }
          },
        ),
      ],

      child: BlocBuilder<TransferToBkashStepsBloc, TransferToBkashStepsState>(
        builder: (context, depositLaterStepsState) {
          final isFirstStep =
              depositLaterStepsState.currentStep ==
              TransferToBkashStepsBloc.firstStep;
          final isLastStep =
              depositLaterStepsState.currentStep ==
              TransferToBkashStepsBloc.lastStep;

          return Scaffold(
            appBar: AppBar(title: const Text('Transfer To bKash')),
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
                                          .read<TransferToBkashStepsBloc>()
                                          .add(
                                            TransferToBkashGoToPreviousStep(),
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
                                            .read<TransferToBkashStepsBloc>()
                                            .add(
                                              TransferToBkashValidateStep(4),
                                            );
                                        _verifyCardPIN(depositLaterStepsState);
                                        return;
                                      }
                                      context
                                          .read<TransferToBkashStepsBloc>()
                                          .add(TransferToBkashGoToNextStep());
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

  void _verifyCardPIN(TransferToBkashStepsState depositLaterStepsState) {
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

  List<StepItem> _buildSteps(TransferToBkashStepsState state) {
    return [
      StepItem(
        icon: FontAwesomeIcons.moneyBillTransfer,
        widget: TransferFromSection(
          accountNumber: state.selectedAccount?.number,
          accountError:
              state.validationErrors[state.currentStep]?['transferFromAccount'],
          onAccountChanged: (debitCard, selectedAccount) {
            if (debitCard != null) {
              context.read<TransferToBkashStepsBloc>().add(
                TransferToBkashSelectDebitCard(debitCard),
              );
            }
            if (selectedAccount != null) {
              context.read<TransferToBkashStepsBloc>().add(
                TransferToBkashSelectCardAccount(selectedAccount),
              );
            }
          },

          selectedCardNumber: state.selectedCard?.cardNumber,
          accountTypeName: state.selectedAccount?.typeName,
          accountBalance:
              state.selectedAccount != null
                  ? state.selectedAccount!.balance
                  : 0,
          accountWithdrawable:
              state.selectedAccount != null
                  ? state.selectedAccount!.withdrawableBalance
                  : 0,
          accountOperatorName:
              state.selectedCard?.nameOnCard.toTitleCase().trim(),
          accountHolderName:
              state.selectedCard?.nameOnCard.toTitleCase().trim(),
          accountName: state.selectedCard?.nameOnCard.toTitleCase().trim(),
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.mobileScreenButton,
        widget: TransferToMobileSection(
          transferToMobile:
              state.stepData[state.currentStep]?['transferToMobile'],
          transferToMobileError:
              state.validationErrors[state.currentStep]?['transferToMobile'],
          onTransferToMobileChanged: (value) {
            context.read<TransferToBkashStepsBloc>().add(
              TransferToBkashUpdateStepData(
                step: state.currentStep,
                data: {'transferToMobile': value},
              ),
            );
          },
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.coins,
        widget: TransferAmountSection(
          sectionTitle: "Transfer Amount",
          transferAmount:
              state.stepData[state.currentStep]?['transferAmount'].toString() ??
              '',
          transferAmountError:
              state.validationErrors[state.currentStep]?['transferAmount'],
          onTransferAmountChanged: (amount) {
            context.read<TransferToBkashStepsBloc>().add(
              TransferToBkashUpdateStepData(
                step: state.currentStep,
                data: {'transferAmount': amount},
              ),
            );
          },
        ),
      ),

      StepItem(
        icon: FontAwesomeIcons.eye,
        widget: TransferPreviewSection(
          senderName: state.selectedCard?.nameOnCard.toTitleCase().trim() ?? '',
          senderAccount: state.selectedAccount?.number ?? '',
          bkashNumber: state.stepData[1]?['transferToMobile'] ?? '',
          transferAmount: state.stepData[2]?['transferAmount'] ?? '',
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.creditCard,
        widget: CardPinVerificationSection(
          cardNumber: state.selectedCard?.cardNumber,
          cardNumberError: state.validationErrors[0]?['selectedCardNumber'],
          cardPin: state.stepData[state.currentStep]?['cardPin'],
          cardPinError: state.validationErrors[state.currentStep]?['cardPin'],
          onCardPinChanged: (pin) {
            context.read<TransferToBkashStepsBloc>().add(
              TransferToBkashUpdateStepData(
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
            context.read<TransferToBkashStepsBloc>().add(
              TransferToBkashUpdateStepData(
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
      child: BlocBuilder<TransferToBkashStepsBloc, TransferToBkashStepsState>(
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
              _submitTransferToBkash(state);
            },
          );
        },
      ),
    );
  }

  void _submitTransferToBkash(TransferToBkashStepsState state) {
    context.read<TransferToBkashStepsBloc>().add(TransferToBkashSubmit());
  }
}
