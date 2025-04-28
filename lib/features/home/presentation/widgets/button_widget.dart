import 'package:flutter/material.dart';
import 'package:pashboi/core/utils/app_context.dart';

class CustomButton extends StatelessWidget {
  final BuildContext context;
  final String text;
  final String route;

  const CustomButton(this.context, this.text, this.route, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: context.theme.colorScheme.surface,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: context.theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
