import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNav extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    required this.selectedIndex,
    required this.onTap,
    super.key,
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
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // First row always shown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(3, (i) => _navItem(i)),
          ),
          // Expandable second row
          if (isExpanded) ...[
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (i) => _navItem(i + 3)),
            ),
          ],
          // Toggle button
          IconButton(
            icon: Icon(
              isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
            ),
            onPressed: () => setState(() => isExpanded = !isExpanded),
          ),
        ],
      ),
    );
  }

  Widget _navItem(int index) {
    final item = menuItems[index];
    final selected = index == widget.selectedIndex;

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            item['icon'],
            color: selected ? Theme.of(context).primaryColor : Colors.grey,
          ),
          SizedBox(height: 4),
          Text(
            item['label'],
            style: TextStyle(
              fontSize: 12,
              color: selected ? Theme.of(context).primaryColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
