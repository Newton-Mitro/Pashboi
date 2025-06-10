import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class TransferFromSection extends StatelessWidget {
  final String? selectedAccountNumber;
  final void Function(String?)? onAccountChanged;

  final String cardNumber;
  final String accountType;
  final String availableBalance;
  final String withdrawableBalance;

  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final bool isFirstStep;
  final bool isLastStep;

  // The available account options to select from
  final List<String> accountNumbers;

  const TransferFromSection({
    super.key,
    required this.selectedAccountNumber,
    required this.onAccountChanged,
    required this.cardNumber,
    required this.accountType,
    required this.availableBalance,
    required this.withdrawableBalance,
    required this.accountNumbers,
    this.onNext,
    this.onPrevious,
    this.isFirstStep = false,
    this.isLastStep = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border.all(color: colorScheme.primary),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Money Will Be Transferred From",
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Form fields
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    AppDropdownSelect(
                      label: "Select Account Number",
                      value: selectedAccountNumber,
                      items:
                          accountNumbers
                              .map(
                                (acc) => DropdownMenuItem(
                                  value: acc,
                                  child: Text(acc),
                                ),
                              )
                              .toList(),
                      prefixIcon: Icons.account_balance,
                      onChanged: onAccountChanged ?? (_) {},
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: TextEditingController(text: cardNumber),
                      enabled: false,
                      label: "Card Number",
                      prefixIcon: Icon(
                        FontAwesomeIcons.creditCard,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: TextEditingController(text: accountType),
                      enabled: false,
                      label: "Account Type",
                      prefixIcon: Icon(
                        FontAwesomeIcons.tag,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: TextEditingController(text: availableBalance),
                      enabled: false,
                      label: "Available Balance",
                      prefixIcon: Icon(
                        FontAwesomeIcons.coins,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: TextEditingController(
                        text: withdrawableBalance,
                      ),
                      enabled: false,
                      label: "Withdrawable Balance",
                      prefixIcon: Icon(
                        FontAwesomeIcons.coins,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Navigation buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isFirstStep
                ? const SizedBox(width: 100)
                : AppPrimaryButton(
                  horizontalPadding: 10,
                  iconBefore: const Icon(FontAwesomeIcons.angleLeft),
                  label: "Previous",
                  onPressed: onPrevious,
                ),
            isLastStep
                ? const SizedBox(width: 100)
                : AppPrimaryButton(
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
