import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/auth/presentation/bloc/mobile_number_verification_bloc/mobile_number_verification_bloc.dart';
import 'package:pashboi/features/authenticated_pages/cards/domain/entities/debit_card_entity.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/domain/entities/tenure_amount_entity.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/domain/entities/tenure_entity.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/account_nominee_section/account_nominee_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/account_preview_section/account_preview_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/account_opening_details_section/account_opening_details_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/card_pin_verification_section/card_pin_verification_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/otp_verification_section/otp_verification_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/transfer_from_section/transfer_from_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/domain/entities/saving_account_entity.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';
import 'package:progress_stepper/progress_stepper.dart';

class AccountOpeningPage extends StatefulWidget {
  const AccountOpeningPage({super.key});

  @override
  State<AccountOpeningPage> createState() => _AccountOpeningPageState();
}

class _AccountOpeningPageState extends State<AccountOpeningPage> {
  // Constants
  static const int _otpDuration = 60;
  static const int _otpLength = 6;
  static const int _pinLength = 4;
  static const int _totalSteps = 6;

  // Step management
  int _currentStep = 1;

  // Controllers - organized by section
  final _accountControllers = _AccountControllers();
  final _accountOpeningControllers = _AccountOpeningControllers();
  final _pinController = TextEditingController();
  late final List<TextEditingController> _otpControllers;
  late final List<FocusNode> _focusNodes;
  late final CountDownController _countDownController;

  // State variables - organized by section
  final _transferFromState = _TransferFromState();
  final _accountOpeningState = _AccountOpeningState();
  final _nomineeState = _NomineeState();
  String? _pinError;
  String? _otpError;
  bool _isWaiting = true;

  // Data
  late final DebitCardEntity _myCards;
  final List<TenureEntity> _tenures = [];
  final List<TenureAmountEntity> _installmentAmounts = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeData();
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
    _accountControllers.dispose();
    _accountOpeningControllers.dispose();
    _pinController.dispose();

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

  // Navigation methods
  void _goNext() {
    if (_currentStep == _totalSteps - 1 && _validateCardPIN()) {
      _prepareOtpStep();
      _submitCardPin();
      setState(() => _currentStep++);
    }

    if (_validateCurrentStep() && _currentStep < 5) {
      setState(() => _currentStep++);
    }
  }

  void _goPrevious() {
    if (_currentStep > 1) {
      setState(() => _currentStep--);
    }
  }

  void _prepareOtpStep() {
    _clearOtpFields();
    setState(() {
      _isWaiting = true;
      _otpError = null;
    });
    try {
      _countDownController.restart(duration: _otpDuration);
    } catch (_) {}
  }

  // Validation methods
  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 1:
        return _validateTransferFromStep();
      case 2:
        return _validateAccountOpeningStep();
      case 3:
        return _validateNomineeStep();
      default:
        return true;
    }
  }

  bool _validateTransferFromStep() {
    final isValid = _transferFromState.selectedAccount?.isNotEmpty ?? false;
    setState(() {
      _transferFromState.accountError =
          isValid ? null : 'Please select a source account';
    });
    return isValid;
  }

  bool _validateAccountOpeningStep() {
    setState(() {
      _accountOpeningState.accountNameError =
          _accountOpeningControllers.accountName.text.isEmpty
              ? 'Please enter account name'
              : null;
      _accountOpeningState.tenureError =
          _accountOpeningState.selectedTenure == null
              ? 'Please select a tenure'
              : null;
      _accountOpeningState.installmentAmountError =
          _accountOpeningState.selectedInstallmentAmount == null
              ? 'Please select an installment amount'
              : null;
    });

    return [
      _accountOpeningState.accountNameError,
      _accountOpeningState.tenureError,
      _accountOpeningState.installmentAmountError,
    ].every((error) => error == null);
  }

  bool _validateNomineeStep() {
    setState(() {
      if (_nomineeState.nominees.value.isEmpty) {
        _nomineeState.nomineeError = 'Please add at least one nominee';
      } else if (_nomineeState.remainingSharePercentage != 0) {
        _nomineeState.nomineeError =
            'Total share percentage must be exactly 100%';
      } else {
        _nomineeState.nomineeError = null;
      }
    });
    return _nomineeState.nomineeError == null;
  }

  bool _validateOtpStep() {
    final otp = _getEnteredOtp();
    setState(() {
      _otpError =
          otp.length < _otpLength
              ? 'Please enter a valid $_otpLength-digit OTP'
              : null;
    });
    return _otpError == null;
  }

  bool _validateCardPIN() {
    if (_pinController.text.length < _pinLength) {
      setState(() => _pinError = 'Please enter a valid $_pinLength-digit PIN');
    } else {
      _pinError = null;
    }

    return _pinError == null;
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

  void _clearOtpFields() {
    for (final controller in _otpControllers) {
      controller.clear();
    }
    for (final focusNode in _focusNodes) {
      focusNode.unfocus();
    }
    setState(() => _isWaiting = false);
  }

  String _getEnteredOtp() {
    return _otpControllers.map((c) => c.text).join();
  }

  void _onOtpComplete() {
    if (mounted) {
      setState(() => _isWaiting = false);
    }
  }

  // Submit methods
  void _submitCardPin() {
    print('Submitting Card PIN: ${_pinController.text}');
  }

  void _submitOpenAnAccount() {
    if (_validateOtpStep()) {
      print('Submitting Open An Account');
    }
  }

  // Account selection handler
  void _onAccountChanged(String? accountNumber) {
    setState(() {
      _transferFromState.selectedAccount = accountNumber;
      _transferFromState.accountError = null;
    });

    if (accountNumber != null) {
      final account = _myCards.cardsAccounts.firstWhere(
        (acc) => acc.number == accountNumber,
      );

      _accountControllers.updateFromAccount(account);
      _accountOpeningControllers.accountName.text = account.accountName;
      _transferFromState.updateAccountInfo(account.accountName);
    }
  }

  // Nominee methods
  void _addNominee() {
    final currentShare =
        int.tryParse(_nomineeState.sharePercentage ?? '0') ?? 0;

    if (_nomineeState.selectedNominee != null &&
        _nomineeState.sharePercentage != null &&
        _nomineeState.totalSharePercentage() + currentShare <= 100) {
      final updated = List<Map<String, String>>.from(
        _nomineeState.nominees.value,
      );
      updated.add({
        'name': _nomineeState.selectedNominee!,
        'share': _nomineeState.sharePercentage!,
      });

      _nomineeState.nominees.value = updated;
      _nomineeState.selectedNominee = null;
      _nomineeState.sharePercentage = null;
    }
    _nomineeState.updateRemainingPercentage();
  }

  void _removeNominee(int index) {
    if (index >= 0 && index < _nomineeState.nominees.value.length) {
      _nomineeState.nominees.value = List.from(_nomineeState.nominees.value)
        ..removeAt(index);
      _nomineeState.updateRemainingPercentage();
    }
  }

  // Data loading methods
  void _loadMyCards() {
    _myCards = DebitCardEntity(
      id: 1,
      cardsAccounts: [
        SavingAccountEntity(
          id: 1,
          number: '1234567890',
          type: 'Savings',
          typeCode: 'SAV',
          accountName: 'John Doe',
          balance: 5000,
          withdrawableBalance: 4600,
          ledgerId: 123,
          interestReate: 3.0,
          accountFor: 'Personal',
          status: 'Active',
          defaultAccount: false,
          nominees: [],
        ),
        SavingAccountEntity(
          id: 2,
          number: '1234567891',
          type: 'Short Term Deposit',
          typeCode: 'STD',
          accountName: 'John Doe',
          balance: 6000,
          withdrawableBalance: 3600,
          ledgerId: 123,
          interestReate: 3.0,
          accountFor: 'Personal',
          status: 'Active',
          defaultAccount: false,
          nominees: [],
        ),
      ],
      isActive: true,
      nameOnCard: 'John Doe',
      cardNumber: '1234 5678 9012 3456',
      type: 'Debit',
      expiryDate: '12/25',
      isVirtual: false,
      isBlock: false,
      stageCode: '123456',
      stageName: 'John Doe',
    );

    _accountControllers.initializeFromCard(_myCards);
  }

  void _loadTenures() {
    _tenures.addAll([
      TenureEntity(
        id: 1,
        durationInMonths: 6,
        durationName: 'Six Months',
        interestRate: 7.5,
      ),
      TenureEntity(
        id: 2,
        durationInMonths: 12,
        durationName: 'Twelve Months',
        interestRate: 8.0,
      ),
      TenureEntity(
        id: 3,
        durationInMonths: 24,
        durationName: 'Twenty Four Months',
        interestRate: 8.5,
      ),
      TenureEntity(
        id: 4,
        durationInMonths: 36,
        durationName: 'Thirty Six Months',
        interestRate: 9.0,
      ),
    ]);
  }

  void _loadInstallmentAmounts() {
    _installmentAmounts.addAll([
      TenureAmountEntity(id: 1, depositAmount: 1000, durationInMonths: 6),
      TenureAmountEntity(id: 2, depositAmount: 2000, durationInMonths: 12),
      TenureAmountEntity(id: 3, depositAmount: 3000, durationInMonths: 24),
      TenureAmountEntity(id: 4, depositAmount: 4000, durationInMonths: 36),
    ]);
  }

  // Tenure selection handler
  void _onTenureChanged(String? value) {
    setState(() {
      _accountOpeningState.selectedTenure = value;
      _accountOpeningState.tenureError = null;
    });

    if (value != null) {
      final tenure = _tenures.firstWhere(
        (t) => t.durationInMonths.toString() == value,
      );
      _accountOpeningControllers.updateFromTenure(tenure);
    }
  }

  // Step icons
  static const List<IconData> _stepIcons = [
    FontAwesomeIcons.moneyBillTransfer,
    FontAwesomeIcons.piggyBank,
    FontAwesomeIcons.userShield,
    FontAwesomeIcons.eye,
    FontAwesomeIcons.creditCard,
    FontAwesomeIcons.key,
  ];

  // Step widgets
  List<Widget> get _stepWidgets {
    return [
      TransferFromSection(
        selectedAccountNumber: _transferFromState.selectedAccount,
        accountError: _transferFromState.accountError,
        onAccountChanged: _onAccountChanged,
        cardNumberController: _accountControllers.cardNumber,
        accounTypeController: _accountControllers.accountType,
        accountBalanceController: _accountControllers.accountBalance,
        accountWithdrawableController: _accountControllers.accountWithdrawable,
        accountNumbers: _myCards.cardsAccounts,
      ),
      AccountOpeningDetailsSection(
        accountNameController: _accountOpeningControllers.accountName,
        accountNameError: _accountOpeningState.accountNameError,
        durationController: _accountOpeningControllers.duration,
        interestRateController: _accountOpeningControllers.interestRate,
        interestTransferAccountController:
            _accountOpeningControllers.interestTransferAccount,
        selectedTenure: _accountOpeningState.selectedTenure,
        tenureError: _accountOpeningState.tenureError,
        tenures: _tenures,
        onTenureChanged: _onTenureChanged,
        selectedInstallmentAmount:
            _accountOpeningState.selectedInstallmentAmount,
        installmentAmountError: _accountOpeningState.installmentAmountError,
        installmentAmounts: _installmentAmounts,
        onInstallmentAmountChanged: (String? value) {
          setState(() {
            _accountOpeningState.selectedInstallmentAmount = value;
            _accountOpeningState.installmentAmountError = null;
          });
        },
      ),
      AccountNomineeSection(
        selectedNominee: _nomineeState.selectedNominee,
        onNomineeChanged: (String? value) {
          setState(() => _nomineeState.selectedNominee = value);
        },
        sharePercentage: _nomineeState.sharePercentage,
        onSharePercentageChanged: (String? value) {
          setState(() => _nomineeState.sharePercentage = value);
        },
        nominees: _nomineeState.nominees,
        nomineeError: _nomineeState.nomineeError,
        onAddNominee: _addNominee,
        onRemoveNominee: _removeNominee,
        remainingPercentage: _nomineeState.remainingSharePercentage,
        canAddNominee: _nomineeState.canAddNominee,
      ),
      AccountPreviewSection(
        selectedAccount: _transferFromState.selectedAccount ?? '',
        accountNameController: _accountOpeningControllers.accountName,
        durationController: _accountOpeningControllers.duration,
        selectedInstallmentAmount:
            _accountOpeningState.selectedInstallmentAmount ?? '',
        interestRateController: _accountOpeningControllers.interestRate,
        interestTransferAccountController:
            _accountOpeningControllers.interestTransferAccount,
        nominees: _nomineeState.nominees.value,
        accountType: 'Savings Account',
        accountHolderName: _transferFromState.accountHolderName,
        accountOperatorName: _transferFromState.accountOperatorName,
      ),
      CardPinVerificationSection(
        cardNumberController: _accountControllers.cardNumber,
        cardPinController: _pinController,
        pinError: _pinError,
      ),
      OtpVerificationSection(
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isLastStep = _currentStep == _totalSteps;
    final isFirstStep = _currentStep == 1;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Open An Account')),
      body: PageContainer(
        child: Column(
          children: [
            _buildProgressStepper(width, context),
            const SizedBox(height: 10),
            _buildStepContent(),
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
                          iconBefore: const Icon(FontAwesomeIcons.angleLeft),
                          label: "Previous",
                          onPressed: _goPrevious,
                        ),
                    isLastStep
                        ? const SizedBox(width: 100)
                        : AppPrimaryButton(
                          horizontalPadding: 10,
                          iconAfter: const Icon(FontAwesomeIcons.angleRight),
                          label: "Next",
                          onPressed: _goNext,
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
  }

  Widget _buildProgressStepper(double width, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: ProgressStepper(
        width: width * 0.9,
        padding: 5,
        height: 50,
        color: context.theme.colorScheme.primary,
        stepCount: _stepIcons.length,
        bluntHead: false,
        bluntTail: false,
        currentStep: _currentStep,
        builder: (context, index, stepWidth) {
          final isCompleted = index <= _currentStep;
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
                _stepIcons[index - 1],
                color:
                    isCompleted
                        ? theme.onPrimary
                        : theme.onSurface.withAlpha(220),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStepContent() {
    return Expanded(
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
            key: ValueKey(_currentStep),
            child: _stepWidgets[_currentStep - 1],
          ),
        ),
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
        duration: 3,
        label: 'Hold & Press to Submit',
        onSubmit: _submitOpenAnAccount,
      ),
    );
  }
}

// Helper classes for better organization
class _AccountControllers {
  late final TextEditingController cardNumber;
  late final TextEditingController accountType;
  late final TextEditingController accountBalance;
  late final TextEditingController accountWithdrawable;

  _AccountControllers();

  void initializeFromCard(DebitCardEntity card) {
    cardNumber = TextEditingController(text: card.cardNumber);
    accountType = TextEditingController(text: card.type);
    accountBalance = TextEditingController(
      text: card.cardsAccounts.first.balance.toString(),
    );
    accountWithdrawable = TextEditingController(
      text: card.cardsAccounts.first.withdrawableBalance.toString(),
    );
  }

  void updateFromAccount(SavingAccountEntity account) {
    accountType.text = account.type;
    accountBalance.text = account.balance.toString();
    accountWithdrawable.text = account.withdrawableBalance.toString();
  }

  void dispose() {
    cardNumber.dispose();
    accountType.dispose();
    accountBalance.dispose();
    accountWithdrawable.dispose();
  }
}

class _AccountOpeningControllers {
  final accountName = TextEditingController();
  final duration = TextEditingController(text: '0');
  final interestRate = TextEditingController(text: '0');
  final interestTransferAccount = TextEditingController();

  void updateFromTenure(TenureEntity tenure) {
    duration.text = tenure.durationInMonths.toString();
    interestRate.text = tenure.interestRate.toString();
  }

  void dispose() {
    accountName.dispose();
    duration.dispose();
    interestRate.dispose();
    interestTransferAccount.dispose();
  }
}

class _TransferFromState {
  String? selectedAccount;
  String? accountError;
  String accountHolderName = 'John Doe';
  String accountOperatorName = 'Mrs. Johnson';

  void updateAccountInfo(String accountName) {
    accountHolderName = accountName;
    accountOperatorName = accountName;
  }
}

class _AccountOpeningState {
  String? selectedTenure;
  String? selectedInstallmentAmount;
  String? accountNameError;
  String? tenureError;
  String? installmentAmountError;
}

class _NomineeState {
  String? selectedNominee;
  String? sharePercentage;
  int remainingSharePercentage = 100;
  final ValueNotifier<List<Map<String, String>>> nominees = ValueNotifier([]);
  String? nomineeError;

  int totalSharePercentage() {
    return nominees.value.fold(0, (sum, item) {
      return sum + (int.tryParse(item['share'] ?? '0') ?? 0);
    });
  }

  bool canAddNominee() {
    final newShare = int.tryParse(sharePercentage ?? '0') ?? 0;
    return selectedNominee != null &&
        sharePercentage != null &&
        newShare > 0 &&
        totalSharePercentage() + newShare <= 100;
  }

  void updateRemainingPercentage() {
    remainingSharePercentage = 100 - totalSharePercentage();
    if (remainingSharePercentage == 0) nomineeError = null;
  }
}
