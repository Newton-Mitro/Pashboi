import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_background.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/ui/new_widget/app_droupdown_input.dart';
import 'package:pashboi/ui/new_widget/app_search_input.dart';

class AddFamilyAndRelatives extends StatefulWidget {
  const AddFamilyAndRelatives({super.key});

  @override
  State<AddFamilyAndRelatives> createState() => _AddFamilyAndRelativesState();
}

class _AddFamilyAndRelativesState extends State<AddFamilyAndRelatives> {
  final TextEditingController _accountHolderController =
      TextEditingController();
  final TextEditingController _accountSearchController =
      TextEditingController();
  final TextEditingController _dropdownController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add Family and Relatives',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Icon(
              FontAwesomeIcons.house,
              size: 20,
              color: context.theme.colorScheme.onSecondary,
            ),
          ],
        ),
      ),
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Render account cards
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Icon(
                            FontAwesomeIcons.users,
                            size: 40,
                            color: context.theme.colorScheme.onSurface,
                          ),
                          const SizedBox(height: 4),
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 1),
                                child: Text(
                                  "Add Account",
                                  style: TextStyle(
                                    color: context.theme.colorScheme.onSurface,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                height: 1,
                                width: 110,
                                color: context.theme.colorScheme.onSurface,
                              ),
                            ],
                          ),

                          const SizedBox(height: 45),

                          AppSearchInput(
                            controller: _accountSearchController,
                            label: "Search Account",
                            prefixIcon: Icon(
                              Icons.person,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 16),
                          AppTextInput(
                            controller: _accountHolderController,
                            label: "Account Holder Name",
                            prefixIcon: Icon(
                              Icons.person,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 16),

                          AppDropdownInput(
                            controller: _dropdownController,
                            label: "Select Account Type",
                            items: ["Savings", "Current", "Business"],
                            prefixIcon: Icon(
                              Icons.account_balance,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 16),

                          AppPrimaryButton(
                            iconBefore: Icon(Icons.person_add),
                            label: "Add Person",
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
