import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/account_nominee_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/account_opening_preview_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/account_opening_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/card_pin_verification_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/otp_verification_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/transfer_from_section.dart';
import 'package:progress_stepper/progress_stepper.dart';

import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/domain/usecases/open_deposit_account_usecase.dart';

import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';

class AccountOpeningPage extends StatefulWidget {
  const AccountOpeningPage({super.key});

  @override
  State<AccountOpeningPage> createState() => _AccountOpeningPageState();
}

class _AccountOpeningPageState extends State<AccountOpeningPage> {
  int currentStep = 1;

  late final List<IconData> steps = [
    FontAwesomeIcons.moneyBillTransfer,
    FontAwesomeIcons.piggyBank,
    FontAwesomeIcons.userShield,
    FontAwesomeIcons.eye,
    FontAwesomeIcons.creditCard,
    FontAwesomeIcons.key,
  ];

  void _goNext() {
    if (currentStep < steps.length) setState(() => currentStep++);
  }

  void _goPrevious() {
    if (currentStep > 1) setState(() => currentStep--);
  }

  List<Widget> get stepWidgets {
    final isFirstStep = currentStep == 1;
    final isLastStep = currentStep == steps.length;

    return [
      TransferFromSection(
        onNext: _goNext,
        onPrevious: _goPrevious,
        isFirstStep: isFirstStep,
        isLastStep: isLastStep,
      ),
      AccountOpeningSection(
        onNext: _goNext,
        onPrevious: _goPrevious,
        isFirstStep: isFirstStep,
        isLastStep: isLastStep,
      ),
      AccountNomineeSection(
        onNext: _goNext,
        onPrevious: _goPrevious,
        isFirstStep: isFirstStep,
        isLastStep: isLastStep,
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
          accountType: 'Deposit',
          accountName: 'John Doe',
          accountNumber: '1234567890',
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
                                : theme.onSurface.withAlpha(150),
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
                    // Final submission logic here
                  },
                ),
              )
              : null,
    );
  }
}
