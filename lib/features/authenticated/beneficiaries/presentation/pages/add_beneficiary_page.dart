import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_search_input.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddBeneficiaryPage extends StatefulWidget {
  const AddBeneficiaryPage({super.key});

  @override
  State<AddBeneficiaryPage> createState() => _AddBeneficiaryPageState();
}

class _AddBeneficiaryPageState extends State<AddBeneficiaryPage> {
  final TextEditingController _accountSearchController =
      TextEditingController();
  final TextEditingController _accountHolderController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Add Beneficiary')),
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
                    "Add Beneficiary",
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
                    color: context.theme.colorScheme.onSurface,
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
