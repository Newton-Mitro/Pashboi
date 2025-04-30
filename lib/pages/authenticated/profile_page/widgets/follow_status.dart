import 'package:flutter/material.dart';
import 'package:pashboi/core/utils/app_context.dart';

class FollowStatus extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onPressed;

  const FollowStatus({
    super.key,
    required this.label,
    required this.value,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Column(
        children: [
          Text(value, style: context.theme.textTheme.labelLarge),
          Text(label, style: context.theme.textTheme.labelMedium),
        ],
      ),
    );
  }
}
