import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/cards/presentation/pages/bloc/debit_card_bloc.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';

class TransferToMobileSection extends StatefulWidget {
  final String? transferToMobile;
  final String? transferToMobileError;
  final void Function(String) onTransferToMobileChanged;

  const TransferToMobileSection({
    super.key,
    required this.transferToMobile,
    required this.transferToMobileError,
    required this.onTransferToMobileChanged,
  });

  @override
  State<TransferToMobileSection> createState() =>
      _TransferToMobileSectionState();
}

class _TransferToMobileSectionState extends State<TransferToMobileSection> {
  @override
  void initState() {
    context.read<DebitCardBloc>().add(DebitCardLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

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
              // Header
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
                    "To bKash Account",
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Form fields
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 5),

                    AppTextInput(
                      initialValue: widget.transferToMobile,
                      enabled: true,
                      label: "bKash Number",
                      errorText: widget.transferToMobileError,
                      prefixIcon: Icon(
                        FontAwesomeIcons.mobileScreen,
                        color: colorScheme.onSurface,
                      ),
                      onChanged: widget.onTransferToMobileChanged,
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
