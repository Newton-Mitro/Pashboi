import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';

class AccountOpeningSection extends StatefulWidget {
  const AccountOpeningSection({super.key});

  @override
  State<AccountOpeningSection> createState() => _AccountOpeningSectionState();
}

class _AccountOpeningSectionState extends State<AccountOpeningSection> {
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
                      prefixIcon: FontAwesomeIcons.user,
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
                      label: "Installment Amount",
                      items:
                          ["500", "1000", "1500", "2000"]
                              .map(
                                (gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(gender),
                                ),
                              )
                              .toList(),
                      onChanged: (p0) {},
                      prefixIcon: FontAwesomeIcons.user,
                    ),
                    AppTextInput(
                      controller: _accountSearchController,
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
