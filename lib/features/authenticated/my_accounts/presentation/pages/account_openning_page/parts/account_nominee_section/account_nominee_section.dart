import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/nominee_entity.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class AccountNomineeSection extends StatefulWidget {
  const AccountNomineeSection({
    super.key,
    required this.onAddNominee,
    required this.onRemoveNominee,
    required this.nominees,
  });

  final void Function(NomineeEntity nominee) onAddNominee;
  final void Function(NomineeEntity nominee) onRemoveNominee;

  final List<NomineeEntity> nominees;

  @override
  State<AccountNomineeSection> createState() => _AccountNomineeSectionState();
}

class _AccountNomineeSectionState extends State<AccountNomineeSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // _buildNomineeSelectionCard(context),
        // const SizedBox(height: 25),
        // _buildAppointedNomineesCard(context),
      ],
    );
  }

  // Widget _buildNomineeSelectionCard(BuildContext context) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: context.theme.colorScheme.surface,
  //       border: Border.all(color: context.theme.colorScheme.primary),
  //       borderRadius: BorderRadius.circular(6),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         _buildHeader(context, "Select Account Nominee"),
  //         Padding(
  //           padding: const EdgeInsets.all(16),
  //           child: Column(
  //             children: [
  //               AppDropdownSelect<String>(
  //                 label: "Nominee",
  //                 prefixIcon: FontAwesomeIcons.user,
  //                 value: widget.nomineeName,
  //                 onChanged: widget.onNomineeChanged,
  //                 items:
  //                     widget.familyMembers.map((member) {
  //                       return DropdownMenuItem(
  //                         value: member.familyMemberName.toTitleCase(),
  //                         child: Text(member.familyMemberName.toTitleCase()),
  //                       );
  //                     }).toList(),
  //               ),
  //               const SizedBox(height: 12),
  //               AppDropdownSelect<double?>(
  //                 label: "Share Percentage",
  //                 prefixIcon: FontAwesomeIcons.percent,
  //                 value: widget.sharePercentage,
  //                 onChanged: widget.onSharePercentageChanged,
  //                 items: List.generate(10, (i) {
  //                   final percent = (i + 1) * 10;
  //                   return DropdownMenuItem(
  //                     value: percent.toDouble(),
  //                     child: Text("$percent %"),
  //                   );
  //                 }),
  //               ),
  //               const SizedBox(height: 16),
  //               AppPrimaryButton(
  //                 iconBefore: const Icon(FontAwesomeIcons.userPlus),
  //                 label: "Add nominee",
  //                 onPressed:
  //                     widget.canAddNominee()
  //                         ? () {
  //                           final nominee = NomineeEntity(
  //                             id: Random().nextInt(1000000000),
  //                             name: widget.nomineeName ?? "",
  //                             relation: "Brother",
  //                             phone: '',
  //                             nationalId: '',
  //                             percentage: widget.sharePercentage,
  //                           );
  //                           widget.onAddNominee(nominee);
  //                         }
  //                         : null,
  //               ),
  //               const SizedBox(height: 10),
  //               Text(
  //                 "Remaining: ${widget.remainingPercentage}%",
  //                 style: TextStyle(
  //                   color:
  //                       widget.nomineeError != null
  //                           ? context.theme.colorScheme.error
  //                           : context.theme.colorScheme.onSurface,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildAppointedNomineesCard(BuildContext context) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: context.theme.colorScheme.surface,
  //       border: Border.all(
  //         color:
  //             widget.nomineeError != null
  //                 ? context.theme.colorScheme.error
  //                 : context.theme.colorScheme.primary,
  //       ),
  //       borderRadius: BorderRadius.circular(5),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         _buildHeader(context, "Appointed Nominee's"),
  //         Padding(
  //           padding: const EdgeInsets.all(16),
  //           child: SizedBox(
  //             height: 120,
  //             child:
  //                 widget.nominees.isEmpty
  //                     ? Center(
  //                       child: Text(
  //                         "No nominees added yet.",
  //                         style: TextStyle(
  //                           color: context.theme.colorScheme.onSurface
  //                               .withOpacity(0.6),
  //                         ),
  //                       ),
  //                     )
  //                     : Scrollbar(
  //                       thumbVisibility: true,
  //                       child: ListView.builder(
  //                         itemCount: widget.nominees.length,
  //                         itemBuilder: (context, index) {
  //                           final nominee = widget.nominees[index];
  //                           return Padding(
  //                             padding: const EdgeInsets.only(bottom: 10),
  //                             child: Row(
  //                               children: [
  //                                 Expanded(
  //                                   flex: 10,
  //                                   child: Container(
  //                                     padding: const EdgeInsets.symmetric(
  //                                       horizontal: 8,
  //                                       vertical: 8,
  //                                     ),
  //                                     decoration: BoxDecoration(
  //                                       border: Border.all(
  //                                         color:
  //                                             context.theme.colorScheme.primary,
  //                                       ),
  //                                       borderRadius: BorderRadius.circular(5),
  //                                     ),
  //                                     child: Row(
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.spaceBetween,
  //                                       children: [
  //                                         Expanded(
  //                                           child: Row(
  //                                             crossAxisAlignment:
  //                                                 CrossAxisAlignment.start,
  //                                             children: [
  //                                               const Icon(
  //                                                 FontAwesomeIcons.user,
  //                                                 size: 16,
  //                                               ),
  //                                               const SizedBox(width: 10),
  //                                               Expanded(
  //                                                 child: Text(
  //                                                   nominee.name,
  //                                                   style: const TextStyle(
  //                                                     fontSize: 14,
  //                                                   ),
  //                                                   overflow:
  //                                                       TextOverflow.visible,
  //                                                   softWrap: true,
  //                                                 ),
  //                                               ),
  //                                             ],
  //                                           ),
  //                                         ),
  //                                         Row(
  //                                           children: [
  //                                             Text(
  //                                               nominee.percentage.toString(),
  //                                             ),
  //                                             const SizedBox(width: 4),
  //                                             const Icon(
  //                                               FontAwesomeIcons.percent,
  //                                               size: 12,
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Expanded(
  //                                   flex: 1,
  //                                   child: IconButton(
  //                                     icon: const Icon(FontAwesomeIcons.trash),
  //                                     onPressed:
  //                                         () => widget.onRemoveNominee(index),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildHeader(BuildContext context, String title) {
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  //     decoration: BoxDecoration(
  //       color: context.theme.colorScheme.primary,
  //       borderRadius: const BorderRadius.only(
  //         topLeft: Radius.circular(5),
  //         topRight: Radius.circular(5),
  //       ),
  //     ),
  //     child: Center(
  //       child: Text(
  //         title,
  //         style: TextStyle(
  //           color: context.theme.colorScheme.onPrimary,
  //           fontSize: 15,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
