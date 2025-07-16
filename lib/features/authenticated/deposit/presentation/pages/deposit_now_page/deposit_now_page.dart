import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_ledger_entity.dart';
import 'package:pashboi/features/authenticated/deposit/presentation/pages/deposit_now_page/bloc/deposit_now_steps_bloc.dart';
import 'package:pashboi/features/authenticated/deposit/presentation/pages/deposit_now_page/parts/search_ledgers_section/search_ledgers_section.dart';
import 'package:pashboi/features/authenticated/deposit/presentation/pages/deposit_now_page/parts/transaction_details_section/transaction_details_section.dart';
import 'package:pashboi/features/authenticated/deposit/presentation/pages/deposit_now_page/parts/transaction_preview_section/transaction_preview_section.dart';
import 'package:progress_stepper/progress_stepper.dart';

import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/auth/presentation/bloc/mobile_number_verification_bloc/mobile_number_verification_bloc.dart';
import 'package:pashboi/features/authenticated/family_and_friends/presentation/pages/family_and_friend_bloc/family_and_friends_bloc/family_and_friends_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/card_pin_verification_section/card_pin_verification_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/otp_verification_section/otp_verification_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/transfer_from_section/transfer_from_section.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';
import 'package:pashboi/shared/widgets/step_item.dart';

class DepositNowPage extends StatefulWidget {
  const DepositNowPage({super.key});

  @override
  State<DepositNowPage> createState() => _DepositNowPageState();
}

class _DepositNowPageState extends State<DepositNowPage> {
  // OTP Verification Section
  static const int _otpDuration = 60;
  static const int _otpLength = 6;
  // From Account Section
  String? _accountNumber;
  String? _accountNumberError;
  final _accountTypeCon = TextEditingController();
  final _accountNameCon = TextEditingController();
  final _accountHolderNameCon = TextEditingController();
  final _accountOperatorNameCon = TextEditingController();
  final _searchAccountNumberCon = TextEditingController();
  final _searchAccountHolderNameCon = TextEditingController();

  final _accountBalanceCon = TextEditingController();
  final _accountWithdrawableCon = TextEditingController();
  List<CollectionLedgerEntity> selectedLedgers = [];

  final _pinController = TextEditingController();
  late final List<TextEditingController> _otpControllers;
  late final List<FocusNode> _focusNodes;
  late final CountDownController _countDownController;
  bool _isWaiting = true;

  // Card Pin Verification Section
  final _cardNumberCon = TextEditingController();
  String? _cardNumberError;
  String? _pinError;
  String? _otpError;

  Widget _buildProgressStepper(double width, DepositNowStepsState state) {
    final theme = context.theme.colorScheme;

    return ProgressStepper(
      width: width * 0.9,
      padding: 5,
      height: 50,
      color: theme.primary,
      stepCount: DepositNowStepsBloc.totalSteps,
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
              _buildSteps()[index - 1].icon,
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

    return BlocBuilder<DepositNowStepsBloc, DepositNowStepsState>(
      builder: (context, depositNowStepsState) {
        final isFirstStep =
            depositNowStepsState.currentStep == DepositNowStepsBloc.firstStep;
        final isLastStep =
            depositNowStepsState.currentStep == DepositNowStepsBloc.lastStep;

        return Scaffold(
          appBar: AppBar(title: const Text('Deposit Now')),
          body: PageContainer(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 15,
                  ),
                  child: _buildProgressStepper(width, depositNowStepsState),
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
                        key: ValueKey(depositNowStepsState.currentStep),
                        child:
                            _buildSteps()[depositNowStepsState.currentStep]
                                .widget,
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
                                context.read<DepositNowStepsBloc>().add(
                                  DepositNowGoToPreviousStep(),
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
                                context.read<DepositNowStepsBloc>().add(
                                  DepositNowGoToNextStep(),
                                );
                              },
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar:
              isLastStep ? _buildSubmitButton(width, context) : null,
        );
      },
    );
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    context.read<FamilyAndFriendsBloc>().add(FetchFamilyAndFriends());
  }

  void _setCollectionLedgers(List<CollectionLedgerEntity> newLedgers) {
    setState(() {
      selectedLedgers =
          newLedgers
              .map(
                (ledger) => ledger.copyWith(
                  depositAmount: ledger.amount,
                  isSelected: false,
                ),
              )
              .toList();
    });
  }

  List<StepItem> _buildSteps() {
    return [
      StepItem(
        icon: FontAwesomeIcons.moneyBillTransfer,
        widget: TransferFromSection(
          accountNumber: _accountNumber,
          accountError: _accountNumberError,
          onAccountChanged: (val) {
            setState(() {
              _accountNumber = val;
            });
          },
          cardNumberController: _cardNumberCon,
          accounTypeController: _accountTypeCon,
          accountBalanceController: _accountBalanceCon,
          accountWithdrawableController: _accountWithdrawableCon,
          accountOperatorNameController: _accountOperatorNameCon,
          accountHolderController: _accountHolderNameCon,
          accountNameController: _accountNameCon,
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.magnifyingGlassChart,
        widget: SearchLedgersSection(
          sectionTitle: "Deposit For",
          accountSearchController: _searchAccountNumberCon,
          accountHolderController: _searchAccountHolderNameCon,
          setCollectionLedgers: _setCollectionLedgers,
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.piggyBank,
        widget: TransactionDetailsSection(
          ledgers: selectedLedgers,
          onToggleSelect: (ledger) {
            setState(() {
              selectedLedgers =
                  selectedLedgers.map((l) {
                    return l.accountId == ledger.accountId &&
                            l.accountNumber == ledger.accountNumber &&
                            l.ledgerId == ledger.ledgerId
                        ? l.copyWith(isSelected: !l.isSelected)
                        : l;
                  }).toList();
            });
          },
          onToggleSelectAll: (selectAll) {
            setState(() {
              selectedLedgers =
                  selectedLedgers
                      .map((l) => l.copyWith(isSelected: selectAll))
                      .toList();
            });
          },
          onAmountChanged: (ledger, newAmount) {
            setState(() {
              selectedLedgers =
                  selectedLedgers.map((l) {
                    return l.accountId == ledger.accountId &&
                            l.accountNumber == ledger.accountNumber &&
                            l.ledgerId == ledger.ledgerId
                        ? l.copyWith(depositAmount: newAmount)
                        : l;
                  }).toList();
            });
          },
        ),
      ),

      StepItem(
        icon: FontAwesomeIcons.eye,
        widget: TransactionPreviewSection(collectionLedgers: selectedLedgers),
      ),
      StepItem(
        icon: FontAwesomeIcons.creditCard,
        widget: CardPinVerificationSection(
          cardNumberController: _cardNumberCon,
          cardNumberError: _cardNumberError,
          cardPinController: _pinController,
          pinError: _pinError,
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.key,
        widget: OtpVerificationSection(
          otpControllers: _otpControllers,
          focusNodes: _focusNodes,
          isWaiting: _isWaiting,
          otpDuration: _otpDuration,
          countDownController: _countDownController,
          otpError: _otpError,
          onResendOtp: _resendOTP,
          onOtpChanged: _onOtpChanged,
          clearOtpFields: _clearOtpFields,
          onOtpComplete: _onOtpComplete,
        ),
      ),
    ];
  }

  Widget _buildSubmitButton(double width, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ProgressSubmitButton(
        width: width - 10,
        height: 100,
        enabled: true,
        backgroundColor: context.theme.colorScheme.primary,
        progressColor: context.theme.colorScheme.secondary,
        foregroundColor: context.theme.colorScheme.onPrimary,
        label: 'Hold & Press to Submit',
        onSubmit: _submitOpenAnAccount,
      ),
    );
  }

  void _clearOtpFields() {
    for (final controller in _otpControllers) {
      controller.clear();
    }
  }

  void _disposeControllers() {
    _cardNumberCon.dispose();
    _accountTypeCon.dispose();
    _accountBalanceCon.dispose();
    _accountWithdrawableCon.dispose();
    _accountOperatorNameCon.dispose();

    try {
      _countDownController.pause();
    } catch (_) {}

    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
  }

  void _initializeControllers() {
    _otpControllers = List.generate(_otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(_otpLength, (_) => FocusNode());
    _countDownController = CountDownController();
    _countDownController.start();

    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          _otpControllers[i].clear();
        }
      });
    }
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < _otpLength - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _onOtpComplete() {}

  void _resendOTP() {
    setState(() => _isWaiting = true);
    try {
      _countDownController.restart(duration: _otpDuration);
    } catch (_) {}

    context.read<VerifyMobileNumberBloc>().add(
      SubmitMobileNumber(mobileNumber: "0123456789", isRegistered: true),
    );
  }

  void _submitOpenAnAccount() {}
}
