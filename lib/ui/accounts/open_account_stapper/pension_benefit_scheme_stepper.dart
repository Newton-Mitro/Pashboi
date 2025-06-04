import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:progress_stepper/progress_stepper.dart';

class PensionBenefitSchemeStepper extends StatefulWidget {
  const PensionBenefitSchemeStepper({super.key});

  @override
  State<PensionBenefitSchemeStepper> createState() =>
      _PensionBenefitSchemeStepperState();
}

class _PensionBenefitSchemeStepperState
    extends State<PensionBenefitSchemeStepper> {
  int currentStep = 1;

  @override
  Widget build(BuildContext context) {
    final List<Icon> steps = [
      Icon(
        FontAwesomeIcons.moneyBillTransfer,
        size: 20,
        color: context.theme.colorScheme.onPrimary,
      ),
      Icon(
        FontAwesomeIcons.user,
        size: 20,
        color: context.theme.colorScheme.onPrimary,
      ),
      Icon(
        FontAwesomeIcons.envelopeOpen,
        size: 20,
        color: context.theme.colorScheme.onPrimary,
      ),
      Icon(
        FontAwesomeIcons.userPlus,
        size: 20,
        color: context.theme.colorScheme.onPrimary,
      ),
      Icon(
        FontAwesomeIcons.fileLines,
        size: 20,
        color: context.theme.colorScheme.onPrimary,
      ),
      Icon(
        FontAwesomeIcons.fileCircleCheck,
        size: 20,
        color: context.theme.colorScheme.onPrimary,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pension Benefit Scheme',
              style: TextStyle(
                color: context.theme.colorScheme.surface,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Icon(
              FontAwesomeIcons.house,
              size: 20,
              color: context.theme.colorScheme.surface,
            ),
          ],
        ),
      ),
      body: PageContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top content
              Column(
                children: [
                  Column(
                    children: [
                      ProgressStepper(
                        width: 350,
                        height: 50,
                        stepCount: steps.length,
                        bluntHead: false,
                        bluntTail: false,
                        currentStep: currentStep,
                        builder: (
                          BuildContext context,
                          int index,
                          double widthOfStep,
                        ) {
                          return ProgressStepWithChevron(
                            width: widthOfStep,
                            height: 50,
                            defaultColor: Colors.transparent,
                            progressColor: context.theme.colorScheme.primary,
                            borderWidth: 1,
                            wasCompleted: index <= currentStep,
                            child: Center(child: steps[index - 1]),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      getStepContent(),
                    ],
                  ),
                ],
              ),

              Row(
                spacing: 8,
                children: [
                  AppPrimaryButton(
                    iconBefore: Icon(FontAwesomeIcons.angleLeft),
                    label: "Pevious",
                    onPressed: () {
                      setState(() {
                        if (currentStep > 1) currentStep--;
                      });
                    },
                  ),
                  AppPrimaryButton(
                    iconAfter: Icon(FontAwesomeIcons.angleRight),
                    label: "Next",
                    onPressed: () {
                      setState(() {
                        if (currentStep < 6) currentStep++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getStepContent() {
    switch (currentStep) {
      case 1:
        return Container(child: Text("Step 1: Transfer money details"));
      case 2:
        return Text("Step 2: Personal Information");
      case 3:
        return Text("Step 3: Email Verification");
      case 4:
        return Text("Step 4: Add Beneficiary");
      case 5:
        return Text("Step 5: Upload Documents");
      case 6:
        return Text("Step 6: Confirmation");
      default:
        return Text("Unknown Step");
    }
  }
}
