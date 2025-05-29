import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class ExpandableCard extends StatefulWidget {
  const ExpandableCard({super.key});

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool isExpanded = false;

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          /// Header
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.theme.colorScheme.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(isExpanded ? 0 : 8),
                bottomRight: Radius.circular(isExpanded ? 0 : 8),
              ),
            ),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.user,
                      size: 15,
                      color: context.theme.colorScheme.onPrimary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Md Israfil",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.theme.colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: toggleExpanded,
                  child: Icon(
                    isExpanded
                        ? FontAwesomeIcons.chevronUp
                        : FontAwesomeIcons.chevronDown,
                    size: 15,
                    color: context.theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          if (isExpanded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.theme.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 6,
                        children: [
                          Icon(FontAwesomeIcons.phoneVolume, size: 15),
                          Text("Mobile number"),
                        ],
                      ),
                      Row(children: [Text("+880-1815458842")]),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
