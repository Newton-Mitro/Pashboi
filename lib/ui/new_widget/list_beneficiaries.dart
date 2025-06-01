import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class ListBeneficiaries extends StatelessWidget {
  const ListBeneficiaries({
    super.key,
    required this.icon,
    required this.titleText,
    required this.subtitleText,
    this.onTap,
  });
  final IconData icon;
  final String titleText;
  final String subtitleText;
  final VoidCallback? onTap;
  @override
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text section aligned to start
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: context.theme.colorScheme.onSurface,
                ),
              ),
              Text(
                subtitleText,
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

        // Icon aligned to end
        Icon(icon, size: 15, color: context.theme.colorScheme.error),
      ],
    );
  }
}
