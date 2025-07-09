import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/auth/presentation/bloc/mobile_number_verification_bloc/mobile_number_verification_bloc.dart';
import 'package:pashboi/features/authenticated/family_and_friends/presentation/pages/family_and_friend_bloc/family_and_friends_bloc/family_and_friends_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/nominee_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/tenure_amount_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/tenure_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/bloc/account_opening_steps_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/account_nominee_section/account_nominee_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/account_preview_section/account_preview_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/account_opening_details_section/account_opening_details_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/card_pin_verification_section/card_pin_verification_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/otp_verification_section/otp_verification_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/transfer_from_section/transfer_from_section.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';
import 'package:pashboi/shared/widgets/step_item.dart';
import 'package:progress_stepper/progress_stepper.dart';

class AccountOpeningPage extends StatefulWidget {
  final String productCode;

  const AccountOpeningPage({super.key, required this.productCode});

  @override
  State<AccountOpeningPage> createState() => _AccountOpeningPageState();
}

class _AccountOpeningPageState extends State<AccountOpeningPage> {
  final accountName = TextEditingController();
  final duration = TextEditingController(text: '0');
  final interestRate = TextEditingController(text: '0');
  final interestTransferAccount = TextEditingController();

  late final TextEditingController cardNumber = TextEditingController();
  late final TextEditingController accountType = TextEditingController();
  late final TextEditingController accountBalance = TextEditingController();
  late final TextEditingController accountWithdrawable =
      TextEditingController();

  // Constants
  static const int _otpDuration = 60;
  static const int _otpLength = 6;

  // Controllers - organized by section
  final _pinController = TextEditingController();
  late final List<TextEditingController> _otpControllers;
  late final List<FocusNode> _focusNodes;
  late final CountDownController _countDownController;

  String? _pinError;
  String? _otpError;
  bool _isWaiting = true;

  // Data
  final List<TenureEntity> _tenures = [];
  final List<TenureAmountEntity> _installmentAmounts = [];

  // Nominee Section State
  String? _selectedNominee;
  double _sharePercentage = 0;
  String? _nomineeError;
  double _remainingPercentage = 100;
  final List<NomineeEntity> _addedNominees = [];

  void _addNominee(NomineeEntity nominee) {
    if (_selectedNominee == null || _sharePercentage == 0) {
      setState(() {
        _nomineeError = "Please select nominee and share percentage.";
      });
      return;
    }

    setState(() {
      _addedNominees.add(nominee);

      _remainingPercentage -= _sharePercentage;
      _selectedNominee = null;
      _sharePercentage = 0;
      _nomineeError = null;
    });
  }

  void _removeNominee(int index) {
    setState(() {
      _remainingPercentage += _addedNominees[index].percentage;
      _addedNominees.removeAt(index);
    });
  }

  bool _canAddNominee() {
    final percent = _sharePercentage;
    return percent <= _remainingPercentage && _selectedNominee != null;
  }

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeData();
    context.read<FamilyAndFriendsBloc>().add(FetchFamilyAndFriends());
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _initializeControllers() {
    _otpControllers = List.generate(_otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(_otpLength, (_) => FocusNode());
    _countDownController = CountDownController();
    _countDownController.start();

    // Setup focus listeners for OTP
    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          _otpControllers[i].clear();
        }
      });
    }
  }

  void _initializeData() {
    _loadMyCards();
    _loadTenures();
    _loadInstallmentAmounts();
  }

  void _disposeControllers() {
    cardNumber.dispose();
    accountType.dispose();
    accountBalance.dispose();
    accountWithdrawable.dispose();
    accountName.dispose();
    duration.dispose();
    interestRate.dispose();
    interestTransferAccount.dispose();

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

  // OTP methods
  void _resendOTP() {
    setState(() => _isWaiting = true);
    try {
      _countDownController.restart(duration: _otpDuration);
    } catch (_) {}

    context.read<VerifyMobileNumberBloc>().add(
      SubmitMobileNumber(mobileNumber: "0123456789", isRegistered: true),
    );
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < _otpLength - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _clearOtpFields() {}

  void _onOtpComplete() {}

  void _submitOpenAnAccount() {}

  // Data loading methods
  void _loadMyCards() async {}

  void _loadTenures() {
    _tenures.addAll([]);
  }

  void _loadInstallmentAmounts() {
    _installmentAmounts.addAll([]);
  }

  // Tenure selection handler
  void _onTenureChanged(String? value) {}

  List<StepItem> _buildSteps(
    AccountOpeningStepsState accountOpeningStepsState,
    BuildContext context,
  ) {
    return [
      StepItem(
        icon: FontAwesomeIcons.moneyBillTransfer,
        widget: TransferFromSection(
          selectedAccountNumber:
              accountOpeningStepsState.stepData[AccountOpeningStepsBloc
                  .firstStep]?['selectedAccountNumber'] ??
              '',
          accountError: '',
          onAccountChanged: (val) {
            context.read<AccountOpeningStepsBloc>().add(
              UpdateStepData(step: 0, key: 'selectedAccountNumber', value: val),
            );
          },
          cardNumberController: cardNumber,
          accounTypeController: accountType,
          accountBalanceController: accountBalance,
          accountWithdrawableController: accountWithdrawable,
          accountHolderNameController: accountName,
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.piggyBank,
        widget: AccountOpeningDetailsSection(
          accountNameController: accountName,
          accountNameError: '',
          durationController: duration,
          interestRateController: interestRate,
          interestTransferAccountController: interestTransferAccount,
          selectedTenure: '',
          tenureError: '',
          tenures: _tenures,
          onTenureChanged: _onTenureChanged,
          selectedInstallmentAmount: '',
          installmentAmountError: '',
          installmentAmounts: _installmentAmounts,
          onInstallmentAmountChanged: (String? value) {},
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.userShield,
        widget: BlocBuilder<FamilyAndFriendsBloc, FamilyAndFriendsState>(
          builder: (context, state) {
            return AccountNomineeSection(
              selectedNominee: _selectedNominee,
              onNomineeChanged: (val) => setState(() => _selectedNominee = val),
              sharePercentage: _sharePercentage,
              onSharePercentageChanged:
                  (val) => setState(() => _sharePercentage = val ?? 0),
              nominees: _addedNominees,
              nomineeError: _nomineeError,
              onAddNominee: _addNominee,
              onRemoveNominee: _removeNominee,
              remainingPercentage: _remainingPercentage,
              canAddNominee: _canAddNominee,
              familyMembers: state.familyAndFriends,
            );
          },
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.eye,
        widget: AccountPreviewSection(
          selectedAccount: '1234567890',
          accountNameController: accountName,
          durationController: duration,
          selectedInstallmentAmount: '',
          interestRateController: interestRate,
          interestTransferAccountController: interestTransferAccount,
          nominees: [],
          accountType: 'Savings Account',
          accountHolderName: 'John Doe',
          accountOperatorName: 'Mrs. Johnson',
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.creditCard,
        widget: CardPinVerificationSection(
          cardNumberController: cardNumber,
          cardPinController: _pinController,
          pinError: _pinError,
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.key,
        widget: OtpVerificationSection(
          routeName: AuthRoutesName.myAccountsPage,
          otpControllers: _otpControllers,
          focusNodes: _focusNodes,
          isWaiting: _isWaiting,
          otpDuration: _otpDuration,
          countDownController: _countDownController,
          otpRegId: '',
          otpError: _otpError,
          onResendOtp: _resendOTP,
          onOtpChanged: _onOtpChanged,
          clearOtpFields: _clearOtpFields,
          onOtpComplete: _onOtpComplete,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => sl<AccountOpeningStepsBloc>(),
      child: BlocBuilder<AccountOpeningStepsBloc, AccountOpeningStepsState>(
        builder: (context, accountOpeningStepsState) {
          final isFirstStep =
              accountOpeningStepsState.currentStep ==
              AccountOpeningStepsBloc.firstStep;
          final isLastStep =
              accountOpeningStepsState.currentStep ==
              AccountOpeningStepsBloc.lastStep;

          return Scaffold(
            appBar: AppBar(title: const Text('Open An Account')),
            body: PageContainer(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 15,
                    ),
                    child: ProgressStepper(
                      width: width * 0.9,
                      padding: 5,
                      height: 50,
                      color: context.theme.colorScheme.primary,
                      stepCount: AccountOpeningStepsBloc.totalSteps,
                      bluntHead: false,
                      bluntTail: false,
                      currentStep: accountOpeningStepsState.currentStep,
                      builder: (context, index, stepWidth) {
                        final isCompleted =
                            index - 1 <= accountOpeningStepsState.currentStep;
                        final theme = context.theme.colorScheme;

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
                              _buildSteps(
                                accountOpeningStepsState,
                                context,
                              )[index - 1].icon,
                              color:
                                  isCompleted
                                      ? theme.onPrimary
                                      : theme.onSurface.withAlpha(220),
                            ),
                          ),
                        );
                      },
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
                          key: ValueKey(accountOpeningStepsState.currentStep),
                          child:
                              _buildSteps(
                                accountOpeningStepsState,
                                context,
                              )[accountOpeningStepsState.currentStep].widget,
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
                                  context.read<AccountOpeningStepsBloc>().add(
                                    GoToPreviousStep(),
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
                                  context.read<AccountOpeningStepsBloc>().add(
                                    GoToNextStep(),
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
      ),
    );
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
}
