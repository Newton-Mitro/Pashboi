import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/widgets/stepper_setp.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class TransferFromSection extends StepperStep {
  const TransferFromSection({
    super.key,
    super.onNext,
    super.onPrevious,
    super.isFirstStep,
    super.isLastStep,
  });

  @override
  State<TransferFromSection> createState() => _TransferFromSectionState();
}

class _TransferFromSectionState extends State<TransferFromSection> {
  String? _selectedAccountNumber;

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _accountTypeController = TextEditingController();
  final TextEditingController _availableBalanceController =
      TextEditingController();
  final TextEditingController _withdrawableBalanceController =
      TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _accountTypeController.dispose();
    _availableBalanceController.dispose();
    _withdrawableBalanceController.dispose();
    super.dispose();
  }

  // Dummy data for accounts
  final Map<String, Map<String, String>> accountData = {
    "T-00156": {
      "cardNumber": "1234-5678-9012-3456",
      "accountType": "Savings",
      "availableBalance": "1500.00",
      "withdrawableBalance": "1400.00",
    },
    "T-00157": {
      "cardNumber": "2345-6789-0123-4567",
      "accountType": "Checking",
      "availableBalance": "2500.00",
      "withdrawableBalance": "2400.00",
    },
    "T-00158": {
      "cardNumber": "3456-7890-1234-5678",
      "accountType": "Fixed Deposit",
      "availableBalance": "3500.00",
      "withdrawableBalance": "3000.00",
    },
  };

  void _updateFields(String? selectedAccount) {
    if (selectedAccount != null && accountData.containsKey(selectedAccount)) {
      final data = accountData[selectedAccount]!;
      _cardNumberController.text = data['cardNumber'] ?? '';
      _accountTypeController.text = data['accountType'] ?? '';
      _availableBalanceController.text = data['availableBalance'] ?? '';
      _withdrawableBalanceController.text = data['withdrawableBalance'] ?? '';
    } else {
      _cardNumberController.clear();
      _accountTypeController.clear();
      _availableBalanceController.clear();
      _withdrawableBalanceController.clear();
    }
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
                    "Money Will Be Transferred From",
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
                    const SizedBox(height: 5),
                    AppDropdownSelect(
                      label: "Select Account Number",
                      value: _selectedAccountNumber,
                      items:
                          accountData.keys
                              .map(
                                (acc) => DropdownMenuItem(
                                  value: acc,
                                  child: Text(acc),
                                ),
                              )
                              .toList(),
                      prefixIcon: Icons.account_balance,
                      onChanged: (value) {
                        setState(() {
                          _selectedAccountNumber = value;
                          _updateFields(value);
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: _cardNumberController,
                      enabled: false,
                      label: "Card Number",
                      prefixIcon: Icon(
                        FontAwesomeIcons.creditCard,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: _accountTypeController,
                      enabled: false,
                      label: "Account Type",
                      prefixIcon: Icon(
                        FontAwesomeIcons.tag,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: _availableBalanceController,
                      enabled: false,
                      label: "Available Balance",
                      prefixIcon: Icon(
                        FontAwesomeIcons.coins,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: _withdrawableBalanceController,
                      enabled: false,
                      label: "Withdrawable Balance",
                      prefixIcon: Icon(
                        FontAwesomeIcons.coins,
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
            // Left side: Previous button or empty box
            widget.isFirstStep == true
                ? const SizedBox(width: 100) // reserve space
                : AppPrimaryButton(
                  horizontalPadding: 10,
                  iconBefore: const Icon(FontAwesomeIcons.angleLeft),
                  label: "Previous",
                  onPressed: widget.onPrevious,
                ),

            // Right side: Next button or empty box
            widget.isLastStep == true
                ? const SizedBox(width: 100) // reserve space
                : AppPrimaryButton(
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
