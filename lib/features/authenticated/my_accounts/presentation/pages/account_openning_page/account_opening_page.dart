import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/string_casing_extension.dart';
import 'package:pashboi/features/authenticated/beneficiaries/presentation/pages/bloc/beneficiary_bloc.dart';
import 'package:pashboi/features/authenticated/cards/presentation/pages/bloc/debit_card_bloc.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_ledger_entity.dart';
import 'package:pashboi/features/authenticated/authenticated_shared/widgets/otp_verification_section/bloc/otp_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/bloc/account_opening_steps_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/account_holder_section/account_holder_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/account_nominee_section/account_nominee_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/account_opening_details_section/account_opening_details_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/account_preview_section/account_preview_section.dart';
import 'package:progress_stepper/progress_stepper.dart';

import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/authenticated_shared/widgets/card_pin_verification_section/card_pin_verification_section.dart';
import 'package:pashboi/features/authenticated/authenticated_shared/widgets/otp_verification_section/otp_verification_section.dart';
import 'package:pashboi/features/authenticated/authenticated_shared/widgets/transfer_from_section/transfer_from_section.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';
import 'package:pashboi/shared/widgets/step_item.dart';

class AccountOpeningPage extends StatefulWidget {
  final String? productCode;
  final String? productName;
  const AccountOpeningPage({
    super.key,
    required this.productCode,
    required this.productName,
  });

  @override
  State<AccountOpeningPage> createState() => _AccountOpeningPageState();
}

class _AccountOpeningPageState extends State<AccountOpeningPage> {
  Widget _buildProgressStepper(double width, AccountOpeningStepsState state) {
    final theme = context.theme.colorScheme;

    return ProgressStepper(
      width: width * 0.9,
      padding: 5,
      height: 50,
      color: theme.primary,
      stepCount: AccountOpeningStepsBloc.totalSteps,
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
              context.read<AccountOpeningStepsBloc>().add(
                AccountOpeningUpdateStepData(
                  step: 4,
                  data: {'OTPRegId': state.successMessage},
                ),
              );
              context.read<AccountOpeningStepsBloc>().add(
                AccountOpeningGoToNextStep(),
              );
              context.read<OtpBloc>().add(StartOtpCountdown());
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
        BlocListener<OtpBloc, OtpState>(
          listener: (context, state) {
            if (state.otpValues.length == 6 &&
                state.otpValues.every((digit) => digit.isNotEmpty)) {
              context.read<AccountOpeningStepsBloc>().add(
                AccountOpeningUpdateStepData(
                  step: 5,
                  data: {'OTP': state.otpValues.join()},
                ),
              );
            }
          },
        ),
        BlocListener<AccountOpeningStepsBloc, AccountOpeningStepsState>(
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

      child: BlocBuilder<AccountOpeningStepsBloc, AccountOpeningStepsState>(
        builder: (context, accountOpeningStepsState) {
          final isFirstStep =
              accountOpeningStepsState.currentStep ==
              AccountOpeningStepsBloc.firstStep;
          final isLastStep =
              accountOpeningStepsState.currentStep ==
              AccountOpeningStepsBloc.lastStep;

          return Scaffold(
            appBar: AppBar(title: const Text('Open an Account')),
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
                          accountOpeningStepsState,
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
                              key: ValueKey(
                                accountOpeningStepsState.currentStep,
                              ),
                              child:
                                  _buildSteps(
                                    accountOpeningStepsState,
                                  )[accountOpeningStepsState
                                      .currentStep].widget,
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
                                          .read<AccountOpeningStepsBloc>()
                                          .add(
                                            AccountOpeningGoToPreviousStep(),
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
                                      if (accountOpeningStepsState
                                              .currentStep ==
                                          4) {
                                        context
                                            .read<AccountOpeningStepsBloc>()
                                            .add(AccountOpeningValidateStep(4));
                                        _verifyCardPIN(
                                          accountOpeningStepsState,
                                        );
                                        return;
                                      }
                                      context
                                          .read<AccountOpeningStepsBloc>()
                                          .add(AccountOpeningGoToNextStep());
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
    context.read<BeneficiaryBloc>().add(FetchBeneficiaries());
  }

  void _setCollectionLedgers(List<CollectionLedgerEntity> newLedgers) {
    context.read<AccountOpeningStepsBloc>().add(
      AccountOpeningSetCollectionLedgers(ledgers: newLedgers),
    );
  }

  void _verifyCardPIN(AccountOpeningStepsState depositNowStepsState) {
    context.read<DebitCardBloc>().add(
      DebitCardPinVerify(
        accountNumber: depositNowStepsState.selectedAccount!.number,
        cardNumber: depositNowStepsState.selectedCard!.cardNumber,
        nameOnCard:
            depositNowStepsState.selectedCard!.nameOnCard.toLowerCase().trim(),
        cardPIN:
            depositNowStepsState.stepData[depositNowStepsState
                .currentStep]?['cardPin'],
      ),
    );
  }

  List<StepItem> _buildSteps(AccountOpeningStepsState state) {
    return [
      StepItem(
        icon: FontAwesomeIcons.moneyBillTransfer,
        widget: TransferFromSection(
          accountNumber: state.selectedAccount?.number,
          accountError:
              state.validationErrors[state.currentStep]?['transferFromAccount'],
          onAccountChanged: (debitCard, selectedAccount) {
            context.read<AccountOpeningStepsBloc>().add(
              AccountOpeningSelectCardAccount(selectedAccount),
            );
            context.read<AccountOpeningStepsBloc>().add(
              AccountOpeningSelectDebitCard(debitCard),
            );
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
        icon: FontAwesomeIcons.magnifyingGlassChart,
        widget: AccountHolderSection(
          accountHolderNameController: TextEditingController(),
          accountForTextController: TextEditingController(),
          accountOperatorNameController: TextEditingController(),
          accountOperatorNameError: '',
          accountHolderNameError: '',
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.piggyBank,
        widget: AccountOpeningDetailsSection(
          accountNameController: TextEditingController(),
          accountDurationController: TextEditingController(),
          interestRateController: TextEditingController(),
          interestTransferToController: TextEditingController(),
          accountDuration: '',
          tenures: [],
          tenureAmounts: [],
          onTenureChanged: (String? value) {},
          installmentAmount: '',
          onTenureAmountChange: (String? value) {},
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.piggyBank,
        widget: AccountNomineeSection(
          nomineeName: '',
          onNomineeChanged: (value) {},
          sharePercentage: 0,
          onSharePercentageChanged: (value) {},
          onAddNominee: (NomineeEntity) {},
          onRemoveNominee: (int index) {},
          remainingPercentage: 0,
          canAddNominee: () {
            return true;
          },
          nominees: [],
          familyMembers: [],
        ),
      ),

      StepItem(
        icon: FontAwesomeIcons.eye,
        widget: AccountPreviewSection(
          accountNameController: TextEditingController(),
          accountDurationController: TextEditingController(),
          interestRateController: TextEditingController(),
          interestTransferToController: TextEditingController(),
          nominees: [],
          accountType: '',
          accountHolderName: '',
          accountOperatorName: '',
          installmentAmount: '',
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
            context.read<AccountOpeningStepsBloc>().add(
              AccountOpeningUpdateStepData(
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
        ),
      ),
    ];
  }

  Widget _buildSubmitButton(double width, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: BlocBuilder<AccountOpeningStepsBloc, AccountOpeningStepsState>(
        builder: (context, state) {
          return ProgressSubmitButton(
            width: width - 30,
            height: 100,
            enabled: !state.isLoading,
            backgroundColor: context.theme.colorScheme.primary,
            progressColor: context.theme.colorScheme.secondary,
            foregroundColor: context.theme.colorScheme.onPrimary,
            label: 'Hold & Press to Submit',
            onSubmit: () {
              _submitAccountOpening(state);
            },
          );
        },
      ),
    );
  }

  void _submitAccountOpening(AccountOpeningStepsState state) {
    context.read<AccountOpeningStepsBloc>().add(AccountOpeningSubmit());
  }
}
