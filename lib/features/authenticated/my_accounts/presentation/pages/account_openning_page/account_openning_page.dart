import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:progress_stepper/progress_stepper.dart';

import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/auth/presentation/bloc/mobile_number_verification_bloc/mobile_number_verification_bloc.dart';
import 'package:pashboi/features/authenticated/family_and_friends/presentation/pages/family_and_friend_bloc/family_and_friends_bloc/family_and_friends_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/nominee_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/tenure_amount_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/tenure_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/bloc/account_opening_steps_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/account_holder_section/account_holder_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/account_nominee_section/account_nominee_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/account_opening_details_section/account_opening_details_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/account_opening_details_section/bloc/tenure_amount_bloc/tenure_amount_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/account_opening_details_section/bloc/tenure_bloc/tenure_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/account_preview_section/account_preview_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/card_pin_verification_section/card_pin_verification_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/otp_verification_section/otp_verification_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/transfer_from_section/transfer_from_section.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';
import 'package:pashboi/shared/widgets/step_item.dart';

class AccountOpeningPage extends StatefulWidget {
  final String productCode;
  final String productName;

  const AccountOpeningPage({
    super.key,
    required this.productCode,
    required this.productName,
  });

  @override
  State<AccountOpeningPage> createState() => _AccountOpeningPageState();
}

class _AccountOpeningPageState extends State<AccountOpeningPage> {
  // OTP Verification Section
  static const int _otpDuration = 60;
  static const int _otpLength = 6;
  // From Account Section
  String? _accountNumber;
  String? _accountNumberError;
  final _accountTypeCon = TextEditingController();

  final _accountBalanceCon = TextEditingController();
  final _accountWithdrawableCon = TextEditingController();
  // Account Holder Section
  final _accountForTextController = TextEditingController(text: 'Individual');
  final _accountHolderNameCon = TextEditingController();
  String? _accountHolderNameError;

  final _accountOperatorNameCon = TextEditingController();
  String? _accountOperatorNameError;
  // Account Opening Details Section
  final _accountNameCon = TextEditingController();
  String? _accountNameError;
  final _accountDurationCon = TextEditingController(text: '0');
  final _interestRateCon = TextEditingController(text: '0');
  final _interestTransferToCon = TextEditingController();
  final List<TenureEntity> _tenures = [];
  String? _accountDuration;
  String? _accountDurationError;
  String? _installmentAmount;

  String? _installmentAmountError;
  final List<TenureAmountEntity> _installmentAmounts = [];
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

  // Nominee Section
  String? _nomineeName;
  double _sharePercentage = 0;
  String? _nomineeError;
  double _remainingPercentage = 100;
  final List<NomineeEntity> _addedNominees = [];

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

    return MultiBlocListener(
      listeners: [
        BlocListener<TenureBloc, TenureState>(
          listener: (context, state) {
            if (state is TenureSuccess) {
              setState(() {
                final tenuresFiltered = getUniqueTenuresByMonths(state.tenures);
                _tenures.addAll(tenuresFiltered);
              });
            }
          },
        ),
        BlocListener<TenureAmountBloc, TenureAmountState>(
          listener: (context, state) {
            if (state is TenureAmountSuccess) {
              setState(() {
                _installmentAmounts.addAll(state.tenureAmounts);
              });
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
            appBar: AppBar(title: const Text('Open An Account')),
            body: PageContainer(
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
                          key: ValueKey(accountOpeningStepsState.currentStep),
                          child:
                              _buildSteps()[accountOpeningStepsState
                                      .currentStep]
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

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  List<TenureEntity> getUniqueTenuresByMonths(List<TenureEntity> tenures) {
    final uniqueTenures = <TenureEntity>[];

    for (final tenure in tenures) {
      final isDuplicate = uniqueTenures.any(
        (t) => t.durationInMonths == tenure.durationInMonths,
      );
      if (!isDuplicate) {
        uniqueTenures.add(tenure);
      }
    }

    return uniqueTenures;
  }

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeData();
    context.read<FamilyAndFriendsBloc>().add(FetchFamilyAndFriends());
  }

  void _updateNomineeSelection(String? value) {
    setState(() {
      _nomineeName = value;
    });
  }

  void _addNominee(NomineeEntity nominee) {
    if (_nomineeName == null || _sharePercentage == 0) {
      setState(() {
        _nomineeError = "Please select nominee and share percentage.";
      });
      return;
    }

    setState(() {
      _addedNominees.add(nominee);
      _remainingPercentage -= _sharePercentage;
      _nomineeName = null;
      _sharePercentage = 0;
      _nomineeError = null;
    });
  }

  List<StepItem> _buildSteps() {
    return [
      StepItem(
        icon: FontAwesomeIcons.moneyBillTransfer,
        widget: TransferFromSection(
          accountNumber: _accountNumber,
          accountError: _accountNumberError,
          onAccountChanged: (debitCard, selectedAccount) {
            // setState(() {
            //   _accountNumber = val;
            //   _interestTransferToCon.text = val!;
            // });
          },
          selectedCardNumber: '',
          accountTypeName: '',
          accountBalance: '',
          accountWithdrawable: '',
          accountOperatorName: '',
          accountHolderName: '',
          accountName: '',
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.userTie,
        widget: BlocBuilder<FamilyAndFriendsBloc, FamilyAndFriendsState>(
          builder: (context, state) {
            return AccountHolderSection(
              accountHolderNameController: _accountHolderNameCon,
              accountHolderNameError: _accountHolderNameError,
              accountForTextController: _accountForTextController,
              accountOperatorNameController: _accountOperatorNameCon,
              accountOperatorNameError: _accountOperatorNameError,
            );
          },
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.piggyBank,
        widget: AccountOpeningDetailsSection(
          accountNameController: _accountNameCon,
          accountNameError: _accountNameError,
          accountDurationController: _accountDurationCon,
          interestRateController: _interestRateCon,
          interestTransferToController: _interestTransferToCon,
          accountDuration: _accountDuration,
          accountDurationError: _accountDurationError,
          tenures: _tenures,
          onTenureChanged: _onTenureChanged,
          installmentAmount: _installmentAmount,
          installmentAmountError: _installmentAmountError,
          tenureAmounts: _installmentAmounts,
          onTenureAmountChange: _onTenureAmountChanged,
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.userShield,
        widget: BlocBuilder<FamilyAndFriendsBloc, FamilyAndFriendsState>(
          builder: (context, state) {
            return AccountNomineeSection(
              nomineeName: _nomineeName,
              nomineeError: _nomineeError,
              onNomineeChanged: _updateNomineeSelection,
              sharePercentage: _sharePercentage,
              onSharePercentageChanged:
                  (val) => setState(() => _sharePercentage = val ?? 0),
              nominees: _addedNominees,
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
          accountNameController: _accountOperatorNameCon,
          accountDurationController: _accountDurationCon,
          installmentAmount: _installmentAmount,
          interestRateController: _interestRateCon,
          interestTransferToController: _interestTransferToCon,
          nominees: _addedNominees,
          accountType: widget.productName,
          accountHolderName: _accountHolderNameCon.text,
          accountOperatorName: _accountOperatorNameCon.text,
        ),
      ),
      StepItem(
        icon: FontAwesomeIcons.creditCard,
        widget: CardPinVerificationSection(
          cardNumber: '',
          cardNumberError: _cardNumberError,
          cardPin: '',
          cardPinError: _pinError,
          onCardPinChanged: (val) {},
        ),
      ),
      StepItem(icon: FontAwesomeIcons.key, widget: OtpVerificationSection()),
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

  bool _canAddNominee() {
    final percent = _sharePercentage;
    return percent <= _remainingPercentage && _nomineeName != null;
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
    _accountDurationCon.dispose();
    _interestRateCon.dispose();
    _interestTransferToCon.dispose();

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

  void _initializeData() {
    context.read<TenureBloc>().add(FetchTenuresEvent(widget.productCode));
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < _otpLength - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _onOtpComplete() {}

  void _onTenureAmountChanged(String? value) {
    setState(() {
      _installmentAmount = value;
    });
  }

  void _onTenureChanged(String? value) {
    context.read<TenureAmountBloc>().add(
      FetchTenureAmountsEvent(
        productCode: widget.productCode,
        duration: value!,
      ),
    );
    setState(() {
      _accountDuration = value;
    });
  }

  void _removeNominee(int index) {
    setState(() {
      _remainingPercentage += _addedNominees[index].percentage;
      _addedNominees.removeAt(index);
    });
  }

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
