import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class SmallCard extends StatelessWidget {
  const SmallCard({
    super.key,
    required this.icon,
    required this.menuName,
    required this.menuDescription,
    required this.buttonText,
    this.onTap,
  });

  final Icon icon;
  final String menuName;
  final String menuDescription;
  final String buttonText; // Added buttonText for consistency
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
                        const SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            buttonText,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
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
