import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/widgets/stepper_setp.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class CardPinVerificationSection extends StepperStep {
  const CardPinVerificationSection({
    super.key,
    super.onNext,
    super.onPrevious,
    super.isFirstStep,
    super.isLastStep,
  });

  @override
  State<CardPinVerificationSection> createState() =>
      _CardPinVerificationSectionState();
}

class _CardPinVerificationSectionState
    extends State<CardPinVerificationSection> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardPinController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardPinController.dispose();
    super.dispose();
  }

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
                      controller: _cardNumberController,
                      enabled: false,
                      label: "Card Number",
                      prefixIcon: Icon(
                        FontAwesomeIcons.creditCard,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppTextInput(
                      controller: _cardPinController,
                      label: "Card PIN",
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
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.isFirstStep == true
                ? const SizedBox(width: 100)
                : AppPrimaryButton(
                  horizontalPadding: 10,
                  iconBefore: const Icon(FontAwesomeIcons.angleLeft),
                  label: "Previous",
                  onPressed: widget.onPrevious,
                ),
            widget.isLastStep == true
                ? const SizedBox(width: 100)
                : AppPrimaryButton(
                  horizontalPadding: 10,
                  iconAfter: const Icon(FontAwesomeIcons.angleRight),
                  label: "Next",
                  onPressed: widget.onNext,
                ),
          ],
        ),
      ],
    );
  }
}
