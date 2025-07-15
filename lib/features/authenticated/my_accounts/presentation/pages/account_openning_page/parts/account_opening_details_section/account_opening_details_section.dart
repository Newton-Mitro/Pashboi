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
    required this.accountDurationController,
    required this.interestRateController,
    required this.interestTransferToController,
    required this.accountDuration,
    required this.tenures,
    required this.tenureAmounts,
    required this.onTenureChanged,
    required this.installmentAmount,
    required this.onTenureAmountChange,
    this.accountNameError,
    this.accountDurationError,
    this.installmentAmountError,
  });

  final TextEditingController accountNameController;
  final TextEditingController accountDurationController;
  final TextEditingController interestRateController;
  final TextEditingController interestTransferToController;

  final List<TenureEntity> tenures;
  final List<TenureAmountEntity> tenureAmounts;

  final String? accountDuration;
  final String? accountDurationError;
  final ValueChanged<String?> onTenureChanged;

  final String? installmentAmount;
  final String? installmentAmountError;
  final ValueChanged<String?> onTenureAmountChange;

  final String? accountNameError;

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
                      value: accountDuration,
                      errorText: accountDurationError,
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
                      onChanged: (value) {
                        final selected = tenures.firstWhere(
                          (t) => t.durationInMonths.toString() == value,
                        );
                        accountDurationController.text =
                            selected.durationInMonths.toString();
                        interestRateController.text =
                            selected.interestRate.toString();
                        onTenureChanged(value);
                      },
                      prefixIcon: Icons.calendar_today,
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: accountDurationController,
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
                      value: installmentAmount,
                      errorText: installmentAmountError,
                      label: "Installment Amount",
                      items:
                          tenureAmounts
                              .map(
                                (amount) => DropdownMenuItem(
                                  value: amount.depositAmount.toString(),
                                  child: Text(amount.depositAmount.toString()),
                                ),
                              )
                              .toList(),
                      onChanged: onTenureAmountChange,
                      prefixIcon: Icons.attach_money,
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: interestTransferToController,
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
