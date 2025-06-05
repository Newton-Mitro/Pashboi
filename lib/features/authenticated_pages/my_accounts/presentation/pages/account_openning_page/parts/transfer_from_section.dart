import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';

class TransferFromSection extends StatefulWidget {
  const TransferFromSection({super.key});

  @override
  State<TransferFromSection> createState() => _TransferFromSectionState();
}

class _TransferFromSectionState extends State<TransferFromSection> {
  String? _dropdownController;
  final TextEditingController _accountSearchController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
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
  }
}
