import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/extensions/string_casing_extension.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/entities/family_and_friend_entity.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';

class AccountHolderSection extends StatelessWidget {
  final String? accountHolderName;
  final void Function(String?) onAccountHolderChanged;
  final String? accountHolderNameError;
  final String? accountOperatorNameError;

  final TextEditingController accountForTextController;
  final TextEditingController accountOperatorNameController;

  final List<FamilyAndFriendEntity> familyMembers;

  const AccountHolderSection({
    super.key,
    required this.accountHolderName,
    required this.onAccountHolderChanged,
    required this.familyMembers,
    required this.accountForTextController,
    required this.accountOperatorNameController,
    required this.accountOperatorNameError,
    required this.accountHolderNameError,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildNomineeSelectionCard(context),
        const SizedBox(height: 25),
        _buildAppointedNomineesCard(context),
      ],
    );
  }

  Widget _buildNomineeSelectionCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        border: Border.all(color: context.theme.colorScheme.primary),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, "Select Account Holder"),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                AppTextInput(
                  controller: accountForTextController,
                  enabled: false,
                  label: "Account Type",
                  prefixIcon: Icon(
                    FontAwesomeIcons.creditCard,
                    color: context.theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),
                AppDropdownSelect<String>(
                  label: "Account Holder",
                  prefixIcon: FontAwesomeIcons.percent,
                  value: accountHolderName,
                  onChanged: onAccountHolderChanged,
                  items:
                      familyMembers.map((member) {
                        return DropdownMenuItem(
                          value: member.familyMemberName.toTitleCase(),
                          child: Text(member.familyMemberName.toTitleCase()),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointedNomineesCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        border: Border.all(
          color:
              accountHolderNameError != null
                  ? context.theme.colorScheme.error
                  : context.theme.colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, "Account Operator"),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppTextInput(
              controller: accountOperatorNameController,
              enabled: false,
              label: "Account Operator",
              prefixIcon: Icon(
                FontAwesomeIcons.creditCard,
                color: context.theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: context.theme.colorScheme.onPrimary,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
