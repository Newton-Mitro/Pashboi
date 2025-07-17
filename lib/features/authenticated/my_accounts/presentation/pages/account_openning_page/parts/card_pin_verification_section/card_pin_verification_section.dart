import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';

class CardPinVerificationSection extends StatelessWidget {
  const CardPinVerificationSection({
    super.key,
    required this.cardNumber,
    required this.cardNumberError,
    required this.cardPin,
    required this.cardPinError,
    required this.onCardPinChanged,
  });

  final String? cardNumber;
  final String? cardPin;
  final String? cardNumberError;
  final String? cardPinError;
  final void Function(String) onCardPinChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border.all(color: colorScheme.primary),
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
                  color: colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Verify Card PIN",
                    style: TextStyle(
                      color: colorScheme.onPrimary,
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
                      initialValue: cardNumber,
                      enabled: false,
                      errorText: cardNumberError,
                      label: "Card Number",
                      prefixIcon: Icon(
                        FontAwesomeIcons.creditCard,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      initialValue: cardPin,
                      label: "Card PIN",
                      errorText: cardPinError,
                      prefixIcon: Icon(
                        FontAwesomeIcons.lock,
                        color: colorScheme.onSurface,
                      ),
                      obscureText: true,
                      onChanged: onCardPinChanged,
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
