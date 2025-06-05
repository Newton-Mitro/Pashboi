import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/account_opening_section.dart';
import 'package:progress_stepper/progress_stepper.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/account_nominee_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/account_opening_preview_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/account_holder_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/card_pin_verification_section.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_openning_page/parts/transfer_from_section.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';

class AccountOpeningPage extends StatefulWidget {
  const AccountOpeningPage({super.key});

  @override
  State<AccountOpeningPage> createState() => _AccountOpeningPageState();
}

class _AccountOpeningPageState extends State<AccountOpeningPage> {
  int currentStep = 1;

  late final List<Widget> stepWidgets = [
    const TransferFromSection(),
    const AccountOpeningSection(),
    const AccountHolderSection(),
    const AccountNomineeSection(),
    const AccountOpeningPreviewSection(),
    const CardPinVerificationSection(),
  ];

  late final List<IconData> steps = [
    FontAwesomeIcons.moneyBillTransfer,
    FontAwesomeIcons.piggyBank,
    FontAwesomeIcons.userGear,
    FontAwesomeIcons.userShield,
    FontAwesomeIcons.eye,
    FontAwesomeIcons.creditCard,
  ];

  @override
  Widget build(BuildContext context) {
    final isFirstStep = currentStep == 1;
    final isLastStep = currentStep == steps.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Open an Account')),
      body: PageContainer(
        child: Stack(
          children: [
            Column(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 15,
                  ),
                  child: Column(
                    children: [
                      ProgressStepper(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: 3,
                        height: 50,
                        color: context.theme.colorScheme.primary,
                        stepCount: steps.length,
                        bluntHead: false,
                        bluntTail: false,
                        currentStep: currentStep,
                        builder: (context, index, width) {
                          return ProgressStepWithChevron(
                            width: width,
                            height: 50,
                            defaultColor: context.theme.colorScheme.surface,
                            progressColor: context.theme.colorScheme.primary,
                            borderColor: context.theme.colorScheme.primary,
                            borderWidth: 1,
                            wasCompleted: index <= currentStep,
                            child: Center(
                              child: Icon(
                                steps[index - 1],
                                color:
                                    index <= currentStep
                                        ? context.theme.colorScheme.onPrimary
                                        : context.theme.colorScheme.onSurface
                                            .withAlpha(150),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                        child: KeyedSubtree(
                          key: ValueKey(currentStep),
                          child: stepWidgets[currentStep - 1],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isFirstStep)
                    AppPrimaryButton(
                      horizontalPadding: 10,
                      iconBefore: const Icon(FontAwesomeIcons.angleLeft),
                      label: "Previous",
                      onPressed: () => setState(() => currentStep--),
                    ),
                  if (!isFirstStep && !isLastStep) const SizedBox(width: 8),
                  if (!isLastStep)
                    AppPrimaryButton(
                      horizontalPadding: 10,
                      iconAfter: const Icon(FontAwesomeIcons.angleRight),
                      label: currentStep == steps.length ? "Finish" : "Next",
                      onPressed:
                          () => setState(() {
                            if (currentStep < steps.length) currentStep++;
                          }),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          isLastStep
              ? Padding(
                padding: const EdgeInsets.all(5.0),
                child: ProgressSubmitButton(
                  width: MediaQuery.of(context).size.width - 10,
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
