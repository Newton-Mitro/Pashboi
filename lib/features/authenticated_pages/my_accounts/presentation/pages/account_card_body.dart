import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class AccountCardBody extends StatelessWidget {
  const AccountCardBody({
    super.key,
    required this.accountName,
    required this.accountNumber,
    required this.icon,
  });

  final String accountName;
  final String accountNumber;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          accountName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: context.theme.colorScheme.onSurface,
          ),
        ),
        Text(
          accountNumber,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Lexend',
            fontWeight: FontWeight.normal,
            color: context.theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
