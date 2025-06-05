import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';

class AccountOperatorSection extends StatefulWidget {
  const AccountOperatorSection({super.key});

  @override
  State<AccountOperatorSection> createState() => _AccountOperatorSectionState();
}

class _AccountOperatorSectionState extends State<AccountOperatorSection> {
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
                  spacing: 20,
                  children: [
                    SizedBox(height: 1),
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
  }
}
