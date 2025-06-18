import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_search_input.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';

class AddFamilyAndRelativesPage extends StatefulWidget {
  const AddFamilyAndRelativesPage({super.key});

  @override
  State<AddFamilyAndRelativesPage> createState() =>
      _AddFamilyAndRelativesPageState();
}

class _AddFamilyAndRelativesPageState extends State<AddFamilyAndRelativesPage> {
  final TextEditingController _accountHolderController =
      TextEditingController();
  final TextEditingController _accountSearchController =
      TextEditingController();

  String? selectedRelationship;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(title: Text('Add Family or Relative')),
      body: PageContainer(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: [
                Icon(
                  FontAwesomeIcons.users,
                  size: 40,
                  color: theme.colorScheme.onSurface,
                ),
                const SizedBox(height: 4),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Add Family or Relative",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 45),
                AppSearchTextInput(
                  controller: _accountSearchController,
                  label: "Account Number",
                  isSearch: true,
                  prefixIcon: Icon(
                    FontAwesomeIcons.piggyBank,
                    color: theme.colorScheme.onSurface,
                  ),
                  onSearchPressed: () {
                    print("User searched: ${_accountSearchController.text}");
                  },
                ),
                const SizedBox(height: 16),
                AppTextInput(
                  controller: _accountHolderController,
                  label: "Account Holder Name",
                  prefixIcon: Icon(
                    Icons.person,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                AppDropdownSelect<String>(
                  value: selectedRelationship,
                  label: "Relationship",
                  items:
                      ["Father", "Mother", "Sibling", "Other"]
                          .map(
                            (gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRelationship = value;
                    });
                  },
                  prefixIcon: FontAwesomeIcons.usersViewfinder,
                  errorText:
                      selectedRelationship == null
                          ? "Please select a relationship"
                          : null,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ProgressSubmitButton(
          width: MediaQuery.of(context).size.width - 10,
          height: 100,
          backgroundColor: context.theme.colorScheme.primary,
          progressColor: context.theme.colorScheme.secondary,
          foregroundColor: context.theme.colorScheme.onPrimary,
          duration: 3,
          label: 'Hold & Press to Submit',
          onSubmit: () {
            if (selectedRelationship == null ||
                _accountHolderController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please fill all fields")),
              );
              return;
            }
          },
        ),
      ),
    );
  }
}
