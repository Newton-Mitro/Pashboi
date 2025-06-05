import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class AccountNomineeSection extends StatefulWidget {
  const AccountNomineeSection({super.key});

  @override
  State<AccountNomineeSection> createState() => _AccountNomineeSectionState();
}

class _AccountNomineeSectionState extends State<AccountNomineeSection> {
  String? _dropdownController;
  String? _sharePercentage;

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
                    "Select Account Nominee",
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
                    Column(
                      spacing: 15,
                      children: [
                        AppDropdownSelect(
                          label: "Select Nominee",
                          prefixIcon: FontAwesomeIcons.user,
                          value: _dropdownController,
                          onChanged: (p0) {
                            setState(() {
                              _dropdownController = p0;
                            });
                          },
                          items:
                              ["Father", "Mother", "Sibling", "Other"]
                                  .map(
                                    (relation) => DropdownMenuItem(
                                      value: relation,
                                      child: Text(relation),
                                    ),
                                  )
                                  .toList(),
                        ),
                        AppDropdownSelect(
                          label: "Share Percentage",
                          prefixIcon: FontAwesomeIcons.percent,
                          value: _sharePercentage,
                          onChanged: (value) {
                            setState(() {
                              _sharePercentage = value;
                            });
                          },
                          items: List.generate(10, (index) {
                            final percentage = (index + 1) * 10;
                            return DropdownMenuItem(
                              value: percentage.toString(),
                              child: Text("$percentage %"),
                            );
                          }),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    AppPrimaryButton(
                      iconBefore: Icon(FontAwesomeIcons.userPlus),
                      label: "Add nominee",
                      onPressed: () {},
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
            color: context.theme.colorScheme.surface,
            border: Border.all(color: context.theme.colorScheme.primary),
            borderRadius: BorderRadius.circular(2),
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
                    "Appointed Nominee's",
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
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: context.theme.colorScheme.surface,
                                  border: Border.all(
                                    color: context.theme.colorScheme.primary,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        spacing: 20,
                                        children: [
                                          Icon(FontAwesomeIcons.user, size: 16),
                                          Text("Md israfil"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("50"),
                                          SizedBox(width: 4),
                                          Icon(
                                            FontAwesomeIcons.percent,
                                            size: 12,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: IconButton(
                                  icon: const Icon(FontAwesomeIcons.trash),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
