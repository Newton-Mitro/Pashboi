import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class CustomBottomNav extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final List<Map<String, dynamic>> menuItems;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.menuItems,
  });

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  bool isExpanded = false;

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
                children: List.generate(
                  5,
                  (i) => Expanded(child: _navItem(widget.menuItems[i], i)),
                ),
              ),

              // Second row (expandable)
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Row(
                  children: List.generate(
                    5,
                    (i) => Expanded(
                      child: _navItem(widget.menuItems[i + 5], i + 5),
                    ),
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
          top: -15,
          child: ClipRect(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: 0.8, // only top half is visible
              child: SizedBox(
                height: 56,
                width: 100,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        isExpanded
                            ? FontAwesomeIcons.chevronDown
                            : FontAwesomeIcons.chevronUp,
                        size: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      Text(
                        isExpanded ? 'less' : 'more',
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _navItem(Map<String, dynamic> item, int index) {
    final selected = index == widget.selectedIndex;

    return TextButton(
      onPressed: () {
        widget.onTap(index);
        // if (isExpanded && index >= 5) {
        //   setState(() {
        //     isExpanded = false;
        //   });
        // }
      },
      style: TextButton.styleFrom(
        foregroundColor:
            selected
                ? context.theme.colorScheme.onPrimary
                : context.theme.colorScheme.inversePrimary,
        padding: const EdgeInsets.symmetric(vertical: 8),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // tighter touch space
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(item['icon'], size: 22),
          const SizedBox(height: 4),
          Text(
            item['label'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
