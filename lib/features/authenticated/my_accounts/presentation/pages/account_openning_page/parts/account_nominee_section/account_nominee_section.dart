import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/extensions/string_casing_extension.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/entities/family_and_friend_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/nominee_entity.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class AccountNomineeSection extends StatelessWidget {
  const AccountNomineeSection({
    super.key,
    required this.nomineeName,
    required this.onNomineeChanged,
    required this.sharePercentage,
    required this.onSharePercentageChanged,
    required this.onAddNominee,
    required this.onRemoveNominee,
    required this.remainingPercentage,
    required this.canAddNominee,
    required this.nominees,
    required this.familyMembers,
    this.nomineeError,
  });

  final String? nomineeName;
  final void Function(String?) onNomineeChanged;

  final double sharePercentage;
  final void Function(double?) onSharePercentageChanged;

  final String? nomineeError;
  final void Function(NomineeEntity) onAddNominee;
  final void Function(int index) onRemoveNominee;
  final double remainingPercentage;
  final bool Function() canAddNominee;
  final List<NomineeEntity> nominees;
  final List<FamilyAndFriendEntity> familyMembers;

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
          _buildHeader(context, "Select Account Nominee"),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                AppDropdownSelect<String>(
                  label: "Nominee",
                  prefixIcon: FontAwesomeIcons.user,
                  value: nomineeName,
                  onChanged: onNomineeChanged,
                  items:
                      familyMembers.map((member) {
                        return DropdownMenuItem(
                          value: member.familyMemberName.toTitleCase(),
                          child: Text(member.familyMemberName.toTitleCase()),
                        );
                      }).toList(),
                  errorText: nomineeError,
                ),
                const SizedBox(height: 12),
                AppDropdownSelect<double?>(
                  label: "Share Percentage",
                  prefixIcon: FontAwesomeIcons.percent,
                  value: sharePercentage,
                  onChanged: onSharePercentageChanged,
                  items: List.generate(10, (i) {
                    final percent = (i + 1) * 10;
                    return DropdownMenuItem(
                      value: percent.toDouble(),
                      child: Text("$percent %"),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                AppPrimaryButton(
                  iconBefore: const Icon(FontAwesomeIcons.userPlus),
                  label: "Add nominee",
                  onPressed:
                      canAddNominee()
                          ? () {
                            final nominee = NomineeEntity(
                              id: Random().nextInt(1000000000),
                              name: nomineeName ?? "",
                              relation: "Brother",
                              phone: '',
                              nationalId: '',
                              percentage: sharePercentage,
                            );
                            onAddNominee(nominee);
                          }
                          : null,
                ),
                const SizedBox(height: 10),
                Text(
                  "Remaining: $remainingPercentage%",
                  style: TextStyle(
                    color:
                        nomineeError != null
                            ? context.theme.colorScheme.error
                            : context.theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
              nomineeError != null
                  ? context.theme.colorScheme.error
                  : context.theme.colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, "Appointed Nominee's"),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 120,
              child:
                  nominees.isEmpty
                      ? Center(
                        child: Text(
                          "No nominees added yet.",
                          style: TextStyle(
                            color: context.theme.colorScheme.onSurface
                                .withOpacity(0.6),
                          ),
                        ),
                      )
                      : Scrollbar(
                        thumbVisibility: true,
                        child: ListView.builder(
                          itemCount: nominees.length,
                          itemBuilder: (context, index) {
                            final nominee = nominees[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 10,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              context.theme.colorScheme.primary,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                FontAwesomeIcons.user,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 10),
                                              Text(nominee.name),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                nominee.percentage.toString(),
                                              ),
                                              const SizedBox(width: 4),
                                              const Icon(
                                                FontAwesomeIcons.percent,
                                                size: 12,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    icon: const Icon(FontAwesomeIcons.trash),
                                    onPressed: () => onRemoveNominee(index),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
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
