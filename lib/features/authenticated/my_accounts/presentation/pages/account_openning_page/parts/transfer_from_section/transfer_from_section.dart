import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';

class TransferFromSection extends StatelessWidget {
  final String? selectedAccountNumber;
  final String? accountError;
  final void Function(String?)? onAccountChanged;

  final TextEditingController cardNumberController;
  final TextEditingController accounTypeController;
  final TextEditingController accountBalanceController;
  final TextEditingController accountWithdrawableController;

  // The available account options to select from
  final List<DepositAccountEntity> accountNumbers;

  const TransferFromSection({
    super.key,
    required this.selectedAccountNumber,
    this.accountError,
    required this.onAccountChanged,
    required this.accountNumbers,
    required this.cardNumberController,
    required this.accounTypeController,
    required this.accountBalanceController,
    required this.accountWithdrawableController,
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
                      label: "Account Number",
                      value: selectedAccountNumber,
                      errorText: accountError,
                      enabled: accountNumbers.isEmpty ? false : true,
                      items:
                          accountNumbers.isNotEmpty
                              ? accountNumbers
                                  .map(
                                    (acc) => DropdownMenuItem(
                                      value: acc.number,
                                      child: Text(acc.number),
                                    ),
                                  )
                                  .toList()
                              : [
                                DropdownMenuItem(
                                  value: '',
                                  child: Text("Accounts loading..."),
                                ),
                              ],
                      prefixIcon: Icons.account_balance,
                      onChanged: onAccountChanged ?? (_) {},
                    ),
                    const SizedBox(height: 12),
                    AppTextInput(
                      controller: cardNumberController,
                      enabled: false,
                      label: "Card Number",
                      prefixIcon: Icon(
                        FontAwesomeIcons.creditCard,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: accounTypeController,
                      enabled: false,
                      label: "Account Type",
                      prefixIcon: Icon(
                        FontAwesomeIcons.tag,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: accountBalanceController,
                      enabled: false,
                      label: "Available Balance",
                      prefixIcon: Icon(
                        FontAwesomeIcons.coins,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: accountWithdrawableController,
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
      ],
    );
  }
}
