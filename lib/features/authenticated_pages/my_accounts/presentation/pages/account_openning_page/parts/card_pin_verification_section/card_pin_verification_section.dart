import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';

class CardPinVerificationSection extends StatelessWidget {
  const CardPinVerificationSection({
    super.key,
    required this.cardNumberController,
    required this.cardPinController,
    this.pinError,
  });

  final TextEditingController cardNumberController;
  final TextEditingController cardPinController;
  final String? pinError;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surface,
            border: Border.all(color: context.theme.colorScheme.primary),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Verify Card PIN",
                    style: TextStyle(
                      color: context.theme.colorScheme.onPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    AppTextInput(
                      controller: cardNumberController,
                      enabled: false,
                      label: "Card Number",
                      prefixIcon: Icon(
                        FontAwesomeIcons.creditCard,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: cardPinController,
                      label: "Card PIN",
                      errorText: pinError,
                      prefixIcon: Icon(
                        FontAwesomeIcons.lock,
                        color: context.theme.colorScheme.onSurface,
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
