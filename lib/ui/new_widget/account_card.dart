import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({
    super.key,
    required this.icon,
    required this.child,
    this.onTap,
    required this.isDefaulter,
  });
  final IconData icon;
  final Widget child;
  final VoidCallback? onTap;
  final bool isDefaulter;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, // needed for InkWell to show ripple
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  !isDefaulter
                      ? context.theme.colorScheme.secondary
                      : context.theme.colorScheme.error,
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
                        child: Icon(
                          icon,
                          size: 30,
                          color: context.theme.colorScheme.surface,
                        ),
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
                    child: child,
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
