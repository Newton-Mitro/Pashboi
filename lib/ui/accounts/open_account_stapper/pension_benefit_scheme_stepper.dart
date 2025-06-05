import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
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
  final TextEditingController _accountSearchController =
      TextEditingController();

  String? _dropdownController;

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
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Icon(FontAwesomeIcons.house, size: 20),
          ],
        ),
      ),
      body: PageContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        ProgressStepper(
                          width: 350,
                          padding: 3,
                          height: 50,
                          color: context.theme.colorScheme.primary,
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 15,
            left: 16,
            right: 16,
          ), // Adjust as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (currentStep > 1)
                AppPrimaryButton(
                  iconBefore: Icon(FontAwesomeIcons.angleLeft),
                  label: "Previous",
                  onPressed: () {
                    setState(() {
                      currentStep--;
                    });
                  },
                ),
              if (currentStep > 1) SizedBox(width: 8),
              AppPrimaryButton(
                iconAfter: Icon(FontAwesomeIcons.angleRight),
                label: currentStep == steps.length ? "Finish" : "Next",
                onPressed: () {
                  setState(() {
                    if (currentStep < steps.length) {
                      currentStep++;
                    } else {
                      // Handle final step action here
                    }
                  });
                },
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
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: context.theme.colorScheme.onPrimary),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Transfer From",
                        style: TextStyle(
                          color: context.theme.colorScheme.onPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      spacing: 10,
                      children: [
                        SizedBox(height: 5),
                        AppDropdownSelect(
                          label: "Account No",
                          value: _dropdownController,
                          items:
                              ["Father", "Mother", "Sibling", "Other"]
                                  .map(
                                    (gender) => DropdownMenuItem(
                                      value: gender,
                                      child: Text(gender),
                                    ),
                                  )
                                  .toList(),
                          prefixIcon: Icon(
                            Icons.account_balance,
                            color: context.theme.colorScheme.onPrimary,
                          ),
                          onChanged: (p0) {},
                        ),
                        AppTextInput(
                          controller: _accountSearchController,
                          label: "Card No",
                          prefixIcon: Icon(
                            FontAwesomeIcons.creditCard,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                        AppTextInput(
                          controller: _accountSearchController,
                          label: "Account Type",
                          prefixIcon: Icon(
                            FontAwesomeIcons.tag,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                        AppTextInput(
                          controller: _accountSearchController,
                          label: "Available Balance",
                          prefixIcon: Icon(
                            FontAwesomeIcons.coins,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case 2:
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: context.theme.colorScheme.onPrimary),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Account For",
                        style: TextStyle(
                          color: context.theme.colorScheme.onPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      spacing: 10,
                      children: [
                        SizedBox(height: 5),
                        AppDropdownSelect(
                          label: "Select Account Type",
                          prefixIcon: Icon(
                            FontAwesomeIcons.tag,
                            color: context.theme.colorScheme.onPrimary,
                          ),
                          value: _dropdownController,
                          onChanged: (p0) {},
                          items:
                              ["Father", "Mother", "Sibling", "Other"]
                                  .map(
                                    (gender) => DropdownMenuItem(
                                      value: gender,
                                      child: Text(gender),
                                    ),
                                  )
                                  .toList(),
                        ),
                        AppDropdownSelect(
                          value: _dropdownController,
                          label: "Select Account Holder",
                          items:
                              ["Father", "Mother", "Sibling", "Other"]
                                  .map(
                                    (gender) => DropdownMenuItem(
                                      value: gender,
                                      child: Text(gender),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (p0) {},
                          prefixIcon: Icon(
                            FontAwesomeIcons.user,
                            color: context.theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: context.theme.colorScheme.onPrimary),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Account Operator",
                        style: TextStyle(
                          color: context.theme.colorScheme.onPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      spacing: 10,
                      children: [
                        SizedBox(height: 5),
                        AppTextInput(
                          controller: _accountSearchController,
                          label: "Select Operator",
                          prefixIcon: Icon(
                            FontAwesomeIcons.user,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case 3:
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: context.theme.colorScheme.onPrimary),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Account Opening Information",
                        style: TextStyle(
                          color: context.theme.colorScheme.onPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      spacing: 10,
                      children: [
                        SizedBox(height: 5),
                        AppTextInput(
                          controller: _accountSearchController,
                          label: "Account Name",
                          prefixIcon: Icon(
                            FontAwesomeIcons.user,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                        AppDropdownSelect(
                          value: _dropdownController,
                          label: "Select Tenure",
                          items:
                              ["Father", "Mother", "Sibling", "Other"]
                                  .map(
                                    (gender) => DropdownMenuItem(
                                      value: gender,
                                      child: Text(gender),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (p0) {},
                          prefixIcon: Icon(
                            FontAwesomeIcons.user,
                            color: context.theme.colorScheme.onPrimary,
                          ),
                        ),
                        AppTextInput(
                          controller: _accountSearchController,
                          label: "Duration In Months",
                          prefixIcon: Icon(
                            FontAwesomeIcons.calendar,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                        AppTextInput(
                          controller: _accountSearchController,
                          label: "Interest Rate",
                          prefixIcon: Icon(
                            FontAwesomeIcons.calendar,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                        AppDropdownSelect(
                          value: _dropdownController,
                          label: "    ",
                          items:
                              ["Father", "Mother", "Sibling", "Other"]
                                  .map(
                                    (gender) => DropdownMenuItem(
                                      value: gender,
                                      child: Text(gender),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (p0) {},
                          prefixIcon: Icon(
                            FontAwesomeIcons.user,
                            color: context.theme.colorScheme.onPrimary,
                          ),
                        ),
                        AppTextInput(
                          controller: _accountSearchController,
                          label: "Interest Transfer To",
                          prefixIcon: Icon(
                            FontAwesomeIcons.buildingColumns,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case 4:
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: context.theme.colorScheme.onPrimary),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Account For",
                        style: TextStyle(
                          color: context.theme.colorScheme.onPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      spacing: 10,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 7, // 80%
                              child: AppDropdownSelect(
                                label: "Select Nominee",
                                prefixIcon: Icon(
                                  FontAwesomeIcons.user,
                                  color: context.theme.colorScheme.onPrimary,
                                ),
                                value: _dropdownController,
                                onChanged: (p0) {},
                                items:
                                    ["Father", "Mother", "Sibling", "Other"]
                                        .map(
                                          (gender) => DropdownMenuItem(
                                            value: gender,
                                            child: Text(gender),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ), // Optional spacing between the two fields
                            Expanded(
                              flex: 3, // 20%
                              child: AppTextInput(
                                controller: _accountSearchController,
                                label: "Percent",
                                prefixIcon: Icon(
                                  FontAwesomeIcons.percent,
                                  color: context.theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        AppPrimaryButton(
                          iconBefore: Icon(FontAwesomeIcons.userPlus),
                          label: "Add nominee",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: context.theme.colorScheme.onPrimary),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Appointed Nominee",
                        style: TextStyle(
                          color: context.theme.colorScheme.onPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      spacing: 10,
                      children: [
                        SizedBox(height: 5),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color:
                                            context.theme.colorScheme.onPrimary,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.user,
                                                size: 16,
                                              ),
                                              SizedBox(width: 6),
                                              Text("Md israfil"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      context
                                                          .theme
                                                          .colorScheme
                                                          .primary,
                                                  border: Border.all(
                                                    color:
                                                        context
                                                            .theme
                                                            .colorScheme
                                                            .onPrimary,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                      ),

                                                  child: Text("50"),
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Icon(
                                                FontAwesomeIcons.percent,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Icon(
                                      FontAwesomeIcons.trash,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case 5:
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: context.theme.colorScheme.onPrimary),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Preview",
                        style: TextStyle(
                          color: context.theme.colorScheme.onPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      spacing: 10,
                      children: [
                        Center(
                          child: Column(
                            spacing: 10,
                            children: [
                              Text(
                                "Account Info",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Account Holder name",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Mr. Johnson",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Operator Name",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Mr. Johnson",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tenure",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "5 Years",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Interest Rate",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    spacing: 2,
                                    children: [
                                      Text(
                                        "12",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Icon(FontAwesomeIcons.percent, size: 12),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Deposit Amount",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    spacing: 2,
                                    children: [
                                      Text(
                                        "50000",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.bangladeshiTakaSign,
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Interest Transfer To",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "L-1356",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),

                              Text(
                                "Appointed Nominee",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Md Israfil",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    spacing: 2,
                                    children: [
                                      Text(
                                        "60",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Icon(FontAwesomeIcons.percent, size: 12),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Jeremy Johnson",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    spacing: 2,
                                    children: [
                                      Text(
                                        "40",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Icon(FontAwesomeIcons.percent, size: 12),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case 6:
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: context.theme.colorScheme.onPrimary),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Card PIN Verification",
                        style: TextStyle(
                          color: context.theme.colorScheme.onPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      spacing: 10,
                      children: [
                        SizedBox(height: 5),

                        AppTextInput(
                          controller: _accountSearchController,
                          label: "Card No",
                          prefixIcon: Icon(
                            FontAwesomeIcons.creditCard,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                        AppTextInput(
                          controller: _accountSearchController,
                          label: "Card Pin",
                          prefixIcon: Icon(
                            FontAwesomeIcons.creditCard,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

      default:
        return Text("palese go back home page");
    }
  }
}
