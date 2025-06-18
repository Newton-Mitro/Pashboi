import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/tenure_amount_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/tenure_entity.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';

class AccountOpeningDetailsSection extends StatelessWidget {
  const AccountOpeningDetailsSection({
    super.key,
    required this.accountNameController,
    required this.durationController,
    required this.interestRateController,
    required this.interestTransferAccountController,
    required this.selectedTenure,
    required this.tenures,
    required this.installmentAmounts,
    required this.onTenureChanged,
    required this.selectedInstallmentAmount,
    required this.onInstallmentAmountChanged,
    this.accountNameError,
    this.tenureError,
    this.installmentAmountError,
  });

  final TextEditingController accountNameController;
  final String? accountNameError;
  final TextEditingController durationController;
  final TextEditingController interestRateController;
  final TextEditingController interestTransferAccountController;
  final List<TenureEntity> tenures;
  final List<TenureAmountEntity> installmentAmounts;

  final String? selectedTenure;
  final String? tenureError;
  final ValueChanged<String?> onTenureChanged;

  final String? selectedInstallmentAmount;
  final String? installmentAmountError;
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
                    "Account Opening Details",
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
                      controller: accountNameController,
                      label: "Account Name",
                      errorText: accountNameError,
                      prefixIcon: Icon(
                        FontAwesomeIcons.user,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppDropdownSelect<String>(
                      value: selectedTenure,
                      errorText: tenureError,
                      label: "Tenure",
                      items:
                          tenures
                              .map(
                                (tenure) => DropdownMenuItem(
                                  value: tenure.durationInMonths.toString(),
                                  child: Text(tenure.durationName),
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
                      errorText: installmentAmountError,
                      label: "Installment Amount",
                      items:
                          installmentAmounts
                              .map(
                                (amount) => DropdownMenuItem(
                                  value: amount.depositAmount.toString(),
                                  child: Text(amount.depositAmount.toString()),
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
      ],
    );
  }
}
