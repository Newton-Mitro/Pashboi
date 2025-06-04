import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.iconData,
    required this.menuName,
    required this.menuDescription,
    this.onTap,
  });

  final IconData iconData;
  final String menuName;
  final String menuDescription;
  final VoidCallback? onTap; // use VoidCallback instead of CallbackAction?

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      borderOnForeground: true,
      shadowColor: const Color.fromARGB(169, 0, 0, 0),
      color:
          context
              .theme
              .colorScheme
              .surface, // needed for InkWell to show ripple
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: context.theme.colorScheme.primary,
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
                    ),
                    child: SizedBox.expand(
                      child: Center(
                        child: Icon(
                          iconData,
                          color: context.theme.colorScheme.onPrimary,
                          size: 30,
                        ), // Replace with `icon` if dynamic
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
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
