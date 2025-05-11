import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class CustomBottomNav extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  bool isExpanded = false;

  final List<Map<String, dynamic>> menuItems = [
    {"icon": FontAwesomeIcons.chartSimple, "label": "Info"},
    {"icon": FontAwesomeIcons.umbrella, "label": "Accounts"},
    {"icon": FontAwesomeIcons.piggyBank, "label": "Deposits"},
    {"icon": FontAwesomeIcons.moneyBillTransfer, "label": "Transfer"},
    {"icon": FontAwesomeIcons.sackDollar, "label": "Acc. Mgmt"},
    {"icon": FontAwesomeIcons.gear, "label": "Settings"},
    {"icon": FontAwesomeIcons.wallet, "label": "Wallet"},
    {"icon": FontAwesomeIcons.receipt, "label": "Statements"},
    {"icon": FontAwesomeIcons.chartPie, "label": "Analytics"},
    {"icon": FontAwesomeIcons.lifeRing, "label": "Support"},
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.only(
            top: 16,
            left: 12,
            right: 12,
            bottom: 8,
          ),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.primary,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // First row
              Row(
                children: List.generate(5, (i) => Expanded(child: _navItem(i))),
              ),

              // Second row (expandable)
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Row(
                  children: List.generate(
                    5,
                    (i) => Expanded(child: _navItem(i + 5)),
                  ),
                ),
                crossFadeState:
                    isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),

        // Positioned Expand/Collapse Icon
        Positioned(
          top: -16,
          child: GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Container(
              height: 36, // Increase the height for larger clickable area
              width: 36, // Make it a circle with width same as height
              decoration: BoxDecoration(
                color: context.theme.colorScheme.primary,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 6),
                ],
                border: Border.all(
                  color: context.theme.colorScheme.primary,
                  width: 1,
                ),
              ),
              child: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_up,
                size: 32,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _navItem(int index) {
    final item = menuItems[index];
    final selected = index == widget.selectedIndex;

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              item['icon'],
              size: 20,
              color:
                  selected ? context.theme.colorScheme.onPrimary : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              item['label'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color:
                    selected
                        ? context.theme.colorScheme.onPrimary
                        : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
