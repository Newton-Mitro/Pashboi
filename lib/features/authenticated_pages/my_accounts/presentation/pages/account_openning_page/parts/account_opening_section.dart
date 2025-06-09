import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/widgets/stepper_setp.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class AccountOpeningSection extends StepperStep {
  const AccountOpeningSection({
    super.key,
    super.onNext,
    super.onPrevious,
    super.isFirstStep,
    super.isLastStep,
  });

  @override
  State<AccountOpeningSection> createState() => _AccountOpeningSectionState();
}

class _AccountOpeningSectionState extends State<AccountOpeningSection> {
  final TextEditingController _accountSearchController =
      TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _interestTransferAccountController =
      TextEditingController();

  String? _selectedTenure;
  String? _selectedInstallmentAmount;

  @override
  void dispose() {
    _accountSearchController.dispose();
    _durationController.dispose();
    _interestRateController.dispose();
    _interestTransferAccountController.dispose();
    super.dispose();
  }

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
                      controller: _accountSearchController,
                      label: "Account Name",
                      prefixIcon: Icon(
                        FontAwesomeIcons.user,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppDropdownSelect<String>(
                      value: _selectedTenure,
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
                      onChanged: (val) {
                        setState(() {
                          _selectedTenure = val;
                        });
                      },
                      prefixIcon: Icons.calendar_today,
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: _durationController,
                      enabled: false,
                      label: "Duration In Months",
                      prefixIcon: Icon(
                        FontAwesomeIcons.calendar,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: _interestRateController,
                      enabled: false,
                      label: "Interest Rate",
                      prefixIcon: Icon(
                        FontAwesomeIcons.percent,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppDropdownSelect<String>(
                      value: _selectedInstallmentAmount,
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
                      onChanged: (val) {
                        setState(() {
                          _selectedInstallmentAmount = val;
                        });
                      },
                      prefixIcon: Icons.attach_money,
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: _interestTransferAccountController,
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
            if (!(widget.isFirstStep ?? true))
              AppPrimaryButton(
                horizontalPadding: 10,
                iconBefore: const Icon(FontAwesomeIcons.angleLeft),
                label: "Previous",
                onPressed: widget.onPrevious,
              ),
            if (!(widget.isLastStep ?? false))
              AppPrimaryButton(
                horizontalPadding: 10,
                iconAfter: const Icon(FontAwesomeIcons.angleRight),
                label: "Next",
                onPressed: widget.onNext,
              ),
          ],
        ),
      ],
    );
  }
}
