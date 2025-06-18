import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';

import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddOperatingAccountPage extends StatefulWidget {
  const AddOperatingAccountPage({super.key});

  @override
  State<AddOperatingAccountPage> createState() =>
      _AddOperatingAccountPageState();
}

class _AddOperatingAccountPageState extends State<AddOperatingAccountPage> {
  final TextEditingController _relationshipController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  String? selectedRelationship;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Add Operating Account')),
      body: PageContainer(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.users,
                  size: 40,
                  color: context.theme.colorScheme.onSurface,
                ),
                const SizedBox(height: 4),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Add Operating Account",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 45),
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
                  prefixIcon: Icons.person_outline,
                  errorText:
                      selectedRelationship == null
                          ? "Please select a relationship"
                          : null,
                ),
                const SizedBox(height: 16),
                AppTextInput(
                  controller: _mobileNumberController,
                  label: "Mobile Number",
                  prefixIcon: Icon(
                    FontAwesomeIcons.mobile,
                    color: context.theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5),
        child: ProgressSubmitButton(
          width: width - 10,
          height: 100,
          backgroundColor: context.theme.colorScheme.primary,
          progressColor: context.theme.colorScheme.secondary,
          foregroundColor: context.theme.colorScheme.onPrimary,
          duration: 3,
          label: 'Hold & Press to Submit',
          onSubmit: () {
            // Final submission logic
          },
        ),
      ),
    );
  }
}
