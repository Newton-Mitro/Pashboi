import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated_pages/cards/domain/entities/card_entity.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/domain/entities/tenure_amount_entity.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/domain/entities/tenure_entity.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/domain/usecases/open_deposit_account_usecase.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/account_nominee_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/account_opening_preview_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/account_opening_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/card_pin_verification_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/otp_verification_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/transfer_from_section.dart';
import 'package:pashboi/features/authenticated_pages/savings/domain/entities/saving_account_entity.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';
import 'package:progress_stepper/progress_stepper.dart';

class AccountOpeningPage extends StatefulWidget {
  const AccountOpeningPage({super.key});

  @override
  State<AccountOpeningPage> createState() => _AccountOpeningPageState();
}

class _AccountOpeningPageState extends State<AccountOpeningPage> {
  int currentStep = 1;

  // Money will be transfer from section
  String? selectedAccount;
  late final TextEditingController cardNumberController;
  late final TextEditingController accounTypeController;
  late final TextEditingController accountBalanceController;
  late final TextEditingController accountWithdrawableController;

  // Account opening section
  late final TextEditingController accountNameController;
  String? selectedTenure;
  late final TextEditingController durationController;
  late final TextEditingController interestRateController;
  String? selectedInstallmentAmount;
  late final TextEditingController interestTransferAccountController;

  // Nominee section
  String? selectedNominee;
  String? sharePercentage;
  int remainingSharePercentage = 100;
  final ValueNotifier<List<Map<String, String>>> nominees = ValueNotifier([]);

  // Verify Card PIN Section
  late final TextEditingController pinController;

  // Otp Verification Section
  late final TextEditingController otpController;
  // pass props

  // API data
  late final CardEntity myCards;
  List<TenureEntity> tenures = [];
  List<TenureAmountEntity> installmentAmounts = [];

  @override
  void initState() {
    super.initState();
    accountNameController = TextEditingController();
    durationController = TextEditingController();
    interestRateController = TextEditingController();
    interestTransferAccountController = TextEditingController();
    getMyCards();
    getTenures();
    getInstallmentAmounts();
  }

  @override
  void dispose() {
    accountNameController.dispose();
    durationController.dispose();
    interestRateController.dispose();
    interestTransferAccountController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (currentStep < steps.length) setState(() => currentStep++);
  }

  void _goPrevious() {
    if (currentStep > 1) setState(() => currentStep--);
  }

  void addNominee() {
    final currentShare = int.tryParse(sharePercentage ?? '0') ?? 0;

    if (selectedNominee != null &&
        sharePercentage != null &&
        totalSharePercentage() + currentShare <= 100) {
      final updated = List<Map<String, String>>.from(nominees.value);
      updated.add({'name': selectedNominee!, 'share': sharePercentage!});
      nominees.value = updated;
      selectedNominee = null;
      sharePercentage = null;
    }

    changeRemainingPercentage();
  }

  void removeNominee(int index) {
    final updated = List<Map<String, String>>.from(nominees.value);
    if (index >= 0 && index < updated.length) {
      updated.removeAt(index);
      nominees.value = updated;
    }
    changeRemainingPercentage();
  }

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
        (totalSharePercentage() + newShare) <= 100;
  }

  void changeRemainingPercentage() {
    setState(() {
      remainingSharePercentage = 100 - totalSharePercentage();
    });
  }

  void getTenures() {
    // This method can be used to fetch tenures from an API or database
    // For now, we are using hardcoded values
    tenures = [
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
    ];
  }

  void getInstallmentAmounts() {
    // This method can be used to fetch installment amounts from an API or database
    // For now, we are using hardcoded values
    installmentAmounts = [
      TenureAmountEntity(id: 1, depositAmount: 1000, durationInMonths: 6),
      TenureAmountEntity(id: 2, depositAmount: 2000, durationInMonths: 12),
      TenureAmountEntity(id: 3, depositAmount: 3000, durationInMonths: 24),
      TenureAmountEntity(id: 4, depositAmount: 4000, durationInMonths: 36),
    ];
  }

  void getMyCards() {
    myCards = CardEntity(
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

    cardNumberController = TextEditingController(text: myCards.cardNumber);
    accounTypeController = TextEditingController(text: myCards.type);
    accountBalanceController = TextEditingController(
      text: myCards.cardsAccounts[0].balance.toString(),
    );
    accountWithdrawableController = TextEditingController(
      text: myCards.cardsAccounts[0].withdrawableBalance.toString(),
    );
  }

  late final List<IconData> steps = [
    FontAwesomeIcons.moneyBillTransfer,
    FontAwesomeIcons.piggyBank,
    FontAwesomeIcons.userShield,
    FontAwesomeIcons.eye,
    FontAwesomeIcons.creditCard,
    FontAwesomeIcons.key,
  ];

  List<Widget> get stepWidgets {
    final isFirstStep = currentStep == 1;
    final isLastStep = currentStep == steps.length;

    return [
      TransferFromSection(
        onNext: _goNext,
        onPrevious: _goPrevious,
        isFirstStep: isFirstStep,
        isLastStep: isLastStep,
        selectedAccountNumber: selectedAccount,
        onAccountChanged: (val) {
          setState(() {
            selectedAccount = val;
          });

          myCards.cardsAccounts
              .where((account) => account.number == val)
              .forEach((account) {
                accounTypeController.text = account.type;
                accountBalanceController.text = account.balance.toString();
                accountWithdrawableController.text =
                    account.withdrawableBalance.toString();
              });
        },
        cardNumberController: cardNumberController,
        accounTypeController: accounTypeController,
        accountBalanceController: accountBalanceController,
        accountWithdrawableController: accountWithdrawableController,
        accountNumbers: myCards.cardsAccounts,
      ),
      AccountOpeningSection(
        onNext: _goNext,
        onPrevious: _goPrevious,
        isFirstStep: isFirstStep,
        isLastStep: isLastStep,
        accountNameController: accountNameController,
        durationController: durationController,
        interestRateController: interestRateController,
        interestTransferAccountController: interestTransferAccountController,
        selectedTenure: selectedTenure,
        tenures: tenures,
        onTenureChanged: (String? value) {
          setState(() {
            selectedTenure = value;
          });
          tenures
              .where((tenure) => tenure.durationInMonths.toString() == value)
              .forEach((tenure) {
                durationController.text = tenure.durationInMonths.toString();
                interestRateController.text = tenure.interestRate.toString();
              });
        },
        selectedInstallmentAmount: selectedInstallmentAmount,
        installmentAmounts: installmentAmounts,
        onInstallmentAmountChanged: (String? value) {
          setState(() {
            selectedInstallmentAmount = value;
          });
        },
      ),
      AccountNomineeSection(
        onNext: _goNext,
        onPrevious: _goPrevious,
        isFirstStep: isFirstStep,
        isLastStep: isLastStep,
        selectedNominee: selectedNominee,
        onNomineeChanged: (String? value) {
          setState(() {
            selectedNominee = value;
          });
        },
        sharePercentage: sharePercentage,
        onSharePercentageChanged: (String? value) {
          setState(() {
            sharePercentage = value;
          });
        },
        nominees: nominees,
        onAddNominee: addNominee,
        onRemoveNominee: removeNominee,
        remainingPercentage: remainingSharePercentage,
        canAddNominee: () => canAddNominee(),
      ),
      AccountOpeningPreviewSection(
        onNext: _goNext,
        onPrevious: _goPrevious,
        isFirstStep: isFirstStep,
        isLastStep: isLastStep,
      ),
      CardPinVerificationSection(
        onNext: _goNext,
        onPrevious: _goPrevious,
        isFirstStep: isFirstStep,
        isLastStep: isLastStep,
      ),
      OtpVerificationSection(
        routeName: AuthRoutesName.myAccountsPage,
        requestObject: OpenDepositAccountUseCaseParams(
          accountType: myCards.type,
          accountName: accountNameController.text,
          accountNumber: selectedAccount ?? '',
          accountBalance: '1000',
          accountCurrency: 'USD',
          accountDescription: 'Savings Account',
          otpRegId: '123456',
          mobileNumber: '1234567890',
        ),
        onNext: _goNext,
        onPrevious: _goPrevious,
        isFirstStep: isFirstStep,
        isLastStep: isLastStep,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isLastStep = currentStep == steps.length;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Open An Account')),
      body: PageContainer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              child: ProgressStepper(
                width: width * 0.9,
                padding: 5,
                height: 50,
                color: context.theme.colorScheme.primary,
                stepCount: steps.length,
                bluntHead: false,
                bluntTail: false,
                currentStep: currentStep,
                builder: (context, index, stepWidth) {
                  final isCompleted = index <= currentStep;
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
                        steps[index - 1],
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
                    key: ValueKey(currentStep),
                    child: stepWidgets[currentStep - 1],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          isLastStep
              ? Padding(
                padding: const EdgeInsets.all(5),
                child: ProgressSubmitButton(
                  width: width - 10,
                  height: 100,
                  backgroundColor: context.theme.colorScheme.primary,
                  progressColor: context.theme.colorScheme.secondary,
                  foregroundColor: context.theme.colorScheme.onPrimary,
                  duration: 3,
                  label: 'Hold & Press to Submit',
                  onSubmit: () {
                    // Final submission logic
                  },
                ),
              )
              : null,
    );
  }
}
