import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class AccountOpeningSection extends StatelessWidget {
  const AccountOpeningSection({
    super.key,
    this.onNext,
    this.onPrevious,
    this.isFirstStep = false,
    this.isLastStep = false,
    required this.accountSearchController,
    required this.durationController,
    required this.interestRateController,
    required this.interestTransferAccountController,
    required this.selectedTenure,
    required this.onTenureChanged,
    required this.selectedInstallmentAmount,
    required this.onInstallmentAmountChanged,
  });

  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final bool isFirstStep;
  final bool isLastStep;

  final TextEditingController accountSearchController;
  final TextEditingController durationController;
  final TextEditingController interestRateController;
  final TextEditingController interestTransferAccountController;

  final String? selectedTenure;
  final ValueChanged<String?> onTenureChanged;

  final String? selectedInstallmentAmount;
  final ValueChanged<String?> onInstallmentAmountChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surface,
            border: Border.all(color: context.theme.colorScheme.primary),
            borderRadius: BorderRadius.circular(6),
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
                  children: [
                    AppTextInput(
                      controller: accountSearchController,
                      label: "Account Name",
                      prefixIcon: Icon(
                        FontAwesomeIcons.user,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppDropdownSelect<String>(
                      value: selectedTenure,
                      label: "Select Tenure",
                      items:
                          ["3 Months", "6 Months", "12 Months"]
                              .map(
                                (tenure) => DropdownMenuItem(
                                  value: tenure,
                                  child: Text(tenure),
                                ),
                              )
                              .toList(),
                      onChanged: onTenureChanged,
                      prefixIcon: Icons.calendar_today,
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: durationController,
                      enabled: false,
                      label: "Duration In Months",
                      prefixIcon: Icon(
                        FontAwesomeIcons.calendar,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: interestRateController,
                      enabled: false,
                      label: "Interest Rate",
                      prefixIcon: Icon(
                        FontAwesomeIcons.percent,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppDropdownSelect<String>(
                      value: selectedInstallmentAmount,
                      label: "Installment Amount",
                      items:
                          ["500", "1000", "1500", "2000"]
                              .map(
                                (amount) => DropdownMenuItem(
                                  value: amount,
                                  child: Text(amount),
                                ),
                              )
                              .toList(),
                      onChanged: onInstallmentAmountChanged,
                      prefixIcon: Icons.attach_money,
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: interestTransferAccountController,
                      label: "Interest Transfer Account",
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
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!isFirstStep)
              AppPrimaryButton(
                horizontalPadding: 10,
                iconBefore: const Icon(FontAwesomeIcons.angleLeft),
                label: "Previous",
                onPressed: onPrevious,
              ),
            if (!isLastStep)
              AppPrimaryButton(
                horizontalPadding: 10,
                iconAfter: const Icon(FontAwesomeIcons.angleRight),
                label: "Next",
                onPressed: onNext,
              ),
          ],
        ),
      ],
    );
  }
}
