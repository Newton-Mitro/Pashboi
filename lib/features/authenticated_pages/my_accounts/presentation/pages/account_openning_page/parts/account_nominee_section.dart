import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class AccountNomineeSection extends StatelessWidget {
  const AccountNomineeSection({
    super.key,
    required this.selectedNominee,
    required this.onNomineeChanged,
    required this.sharePercentage,
    required this.onSharePercentageChanged,
    required this.nominees,
    required this.onAddNominee,
    required this.onRemoveNominee,
    required this.remainingPercentage,
    required this.canAddNominee,
    this.nomineeError,
  });

  final String? selectedNominee;
  final ValueChanged<String?> onNomineeChanged;

  final String? sharePercentage;
  final ValueChanged<String?> onSharePercentageChanged;

  final ValueListenable<List<Map<String, String>>> nominees;
  final String? nomineeError;
  final VoidCallback onAddNominee;
  final void Function(int index) onRemoveNominee;
  final int remainingPercentage;
  final bool Function() canAddNominee;

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
                  label: "Select Nominee",
                  prefixIcon: FontAwesomeIcons.user,
                  value: selectedNominee,
                  onChanged: onNomineeChanged,
                  items:
                      [
                            'John Doe',
                            'Jane Smith',
                            'Alice Johnson',
                            'Bob Brown',
                            'Samantha Lee',
                            'Michael Davis',
                          ]
                          .map(
                            (name) => DropdownMenuItem(
                              value: name,
                              child: Text(name),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 12),
                AppDropdownSelect<String>(
                  label: "Share Percentage",
                  prefixIcon: FontAwesomeIcons.percent,
                  value: sharePercentage,
                  onChanged: onSharePercentageChanged,
                  items: List.generate(10, (i) {
                    final percent = (i + 1) * 10;
                    return DropdownMenuItem(
                      value: percent.toString(),
                      child: Text("$percent %"),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder<List<Map<String, String>>>(
                  valueListenable: nominees,
                  builder: (_, __, ___) {
                    return AppPrimaryButton(
                      iconBefore: const Icon(FontAwesomeIcons.userPlus),
                      label: "Add nominee",
                      onPressed: canAddNominee() ? onAddNominee : null,
                    );
                  },
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
              child: ValueListenableBuilder<List<Map<String, String>>>(
                valueListenable: nominees,
                builder: (context, nomineeList, _) {
                  if (nomineeList.isEmpty) {
                    return Center(
                      child: Text(
                        "No nominees added yet.",
                        style: TextStyle(
                          color: context.theme.colorScheme.onSurface
                              .withOpacity(0.6),
                        ),
                      ),
                    );
                  }
                  return Scrollbar(
                    thumbVisibility: true,
                    child: ListView.builder(
                      itemCount: nomineeList.length,
                      itemBuilder: (context, index) {
                        final nominee = nomineeList[index];
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
                                      color: context.theme.colorScheme.primary,
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
                                          Text(nominee['name'] ?? ''),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(nominee['share'] ?? ''),
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
                  );
                },
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
