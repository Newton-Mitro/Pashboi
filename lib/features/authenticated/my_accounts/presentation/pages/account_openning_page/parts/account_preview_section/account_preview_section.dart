import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/deposit/presentation/pages/deposit_later_page/sections/deposit_later_preview/deposit_later_preview_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/nominee_entity.dart';

class AccountPreviewSection extends StatelessWidget {
  final String? accountName;
  final int accountDuration;
  final double interestRate;
  final String? interestTransferTo;
  final double installmentAmount;
  final List<NomineeEntity> nominees;
  final String? accountType;
  final String? accountHolderName;
  final String? accountOperatorName;

  const AccountPreviewSection({
    super.key,
    required this.accountName,
    required this.accountDuration,
    required this.interestRate,
    required this.interestTransferTo,
    required this.nominees,
    required this.accountType,
    required this.accountHolderName,
    required this.accountOperatorName,
    required this.installmentAmount,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border.all(color: colorScheme.primary, width: 1.2),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Account Preview",
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 450),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const SectionTitle("Account Info"),
                        InfoRow("Account Type", accountType ?? ""),
                        InfoRow("Account Name", accountName ?? ""),
                        InfoRow("Tenure", "$accountDuration Months"),
                        InfoRow(
                          "Interest Rate",
                          interestRate.toString(),
                          icon: FontAwesomeIcons.percent,
                        ),
                        InfoRow(
                          "Deposit Amount",
                          installmentAmount.toString(),
                          icon: FontAwesomeIcons.bangladeshiTakaSign,
                        ),
                        InfoRow(
                          "Interest Transfer To",
                          interestTransferTo ?? "",
                        ),

                        Divider(height: 30, color: colorScheme.primary),

                        const SectionTitle("Account Holder"),
                        InfoRow("Full Name", accountHolderName ?? ""),

                        Divider(height: 30, color: colorScheme.primary),

                        const SectionTitle("Account Operator"),
                        InfoRow("Full Name", accountOperatorName ?? ""),

                        Divider(height: 30, color: colorScheme.primary),

                        const SectionTitle("Appointed Nominees"),
                        for (final nominee in nominees)
                          InfoRow(
                            nominee.name,
                            "${nominee.percentage}",
                            icon: FontAwesomeIcons.percent,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;

  const InfoRow(this.label, this.value, {this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = context.theme.textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textStyle?.copyWith(fontWeight: FontWeight.w600)),
          Row(
            children: [
              Text(value, style: textStyle),
              if (icon != null) ...[
                const SizedBox(width: 4),
                Icon(icon, size: 14),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
