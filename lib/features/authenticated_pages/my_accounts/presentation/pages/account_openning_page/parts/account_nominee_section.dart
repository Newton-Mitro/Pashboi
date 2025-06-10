import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class AccountNomineeController {
  String? selectedNominee;
  String? sharePercentage;

  final ValueNotifier<List<Map<String, String>>> nominees = ValueNotifier([]);

  void addNominee() {
    final currentShare = int.tryParse(sharePercentage ?? '0') ?? 0;

    if (selectedNominee != null &&
        sharePercentage != null &&
        totalSharePercentage() + currentShare <= 100) {
      final updated = List<Map<String, String>>.from(nominees.value);
      updated.add({'name': selectedNominee!, 'share': sharePercentage!});
      nominees.value = updated;
      selectedNominee = null;
      sharePercentage = null;
    }
  }

  void removeNominee(int index) {
    final updated = List<Map<String, String>>.from(nominees.value);
    if (index >= 0 && index < updated.length) {
      updated.removeAt(index);
      nominees.value = updated;
    }
  }

  int totalSharePercentage() {
    return nominees.value.fold(0, (sum, item) {
      return sum + (int.tryParse(item['share'] ?? '0') ?? 0);
    });
  }

  bool canAddNominee() {
    final newShare = int.tryParse(sharePercentage ?? '0') ?? 0;
    return selectedNominee != null &&
        sharePercentage != null &&
        newShare > 0 &&
        (totalSharePercentage() + newShare) <= 100;
  }

  int remainingPercentage() {
    return 100 - totalSharePercentage();
  }
}

class AccountNomineeSection extends StatelessWidget {
  const AccountNomineeSection({
    super.key,
    required this.controller,
    this.onNext,
    this.onPrevious,
    this.isFirstStep = false,
    this.isLastStep = false,
  });

  final AccountNomineeController controller;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final bool isFirstStep;
  final bool isLastStep;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildNomineeSelectionCard(context),
        const SizedBox(height: 25),
        _buildAppointedNomineesCard(context),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!isFirstStep)
              AppPrimaryButton(
                iconBefore: const Icon(FontAwesomeIcons.arrowLeft),
                label: "Previous",
                onPressed: onPrevious,
              ),
            if (!isLastStep)
              AppPrimaryButton(
                iconBefore: const Icon(FontAwesomeIcons.arrowRight),
                label: "Next",
                onPressed: onNext,
              ),
          ],
        ),
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
                  value: controller.selectedNominee,
                  onChanged: (value) {
                    controller.selectedNominee = value;
                    // Force rebuild by notifying listeners for nominees list (hacky but works here)
                    controller.nominees.notifyListeners();
                  },
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
                            (relation) => DropdownMenuItem(
                              value: relation,
                              child: Text(relation),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 12),
                AppDropdownSelect<String>(
                  label: "Share Percentage",
                  prefixIcon: FontAwesomeIcons.percent,
                  value: controller.sharePercentage,
                  onChanged: (value) {
                    controller.sharePercentage = value;
                    controller.nominees.notifyListeners();
                  },
                  items: List.generate(10, (index) {
                    final percentage = (index + 1) * 10;
                    return DropdownMenuItem(
                      value: percentage.toString(),
                      child: Text("$percentage %"),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder<List<Map<String, String>>>(
                  valueListenable: controller.nominees,
                  builder: (_, __, ___) {
                    return AppPrimaryButton(
                      iconBefore: const Icon(FontAwesomeIcons.userPlus),
                      label: "Add nominee",
                      onPressed:
                          controller.canAddNominee()
                              ? () {
                                controller.addNominee();
                              }
                              : null,
                    );
                  },
                ),
                const SizedBox(height: 10),
                ValueListenableBuilder<List<Map<String, String>>>(
                  valueListenable: controller.nominees,
                  builder: (_, __, ___) {
                    return Text(
                      "Remaining: ${controller.remainingPercentage()}%",
                      style: TextStyle(
                        color: context.theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
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
        border: Border.all(color: context.theme.colorScheme.primary),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, "Appointed Nominee's"),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 120, // fixed height for scrolling list
              child: ValueListenableBuilder<List<Map<String, String>>>(
                valueListenable: controller.nominees,
                builder: (context, nominees, _) {
                  if (nominees.isEmpty) {
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
                                onPressed: () {
                                  controller.removeNominee(index);
                                },
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
