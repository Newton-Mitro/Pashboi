import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    super.key,
    required this.icon,
    required this.menuName,
    required this.menuDescription,
    this.onTap,
  });

  final Icon icon;
  final String menuName;
  final String menuDescription;
  final VoidCallback? onTap; // use VoidCallback instead of CallbackAction?

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // needed for InkWell to show ripple
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: context.theme.colorScheme.secondary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                      ),
                    ),
                    child: SizedBox.expand(
                      child: Center(
                        child: icon, // Replace with `icon` if dynamic
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menuName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          menuDescription,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.normal,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
