import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/extensions/string_casing_extension.dart';
import 'package:pashboi/core/utils/taka_formatter.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_ledger_entity.dart';
import 'package:pashboi/features/authenticated/deposit/presentation/pages/deposit_from_bkash_page/parts/transaction_charge_preview_section/bloc/bkash_service_charge_bloc.dart';

class TransactionChargePreviewSection extends StatefulWidget {
  final List<CollectionLedgerEntity> collectionLedgers;
  final double serviceCharge;
  final void Function(double serviceCharge) onServiceChargeChange;

  const TransactionChargePreviewSection({
    super.key,
    required this.collectionLedgers,
    required this.serviceCharge,
    required this.onServiceChargeChange,
  });

  @override
  State<TransactionChargePreviewSection> createState() =>
      _TransactionChargePreviewSectionState();
}

class _TransactionChargePreviewSectionState
    extends State<TransactionChargePreviewSection> {
  @override
  void initState() {
    final totalAmount = widget.collectionLedgers
        .where((ledger) => ledger.isSelected)
        .fold<double>(0, (sum, ledger) => sum + ledger.depositAmount);
    context.read<BkashServiceChargeBloc>().add(
      FetchBkashServiceChargeEvent(totalAmount: totalAmount),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    final totalAmount = widget.collectionLedgers
        .where((ledger) => ledger.isSelected)
        .fold<double>(0, (sum, ledger) => sum + ledger.depositAmount);
    final serviceCharge = widget.serviceCharge;

    final totalAmountWithServiceCharge = totalAmount + serviceCharge;

    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
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
      child: Stack(
        children: [
          // Scrollable content
          Padding(
            padding: const EdgeInsets.only(
              bottom: 90,
            ), // Leave space for fixed bar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
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
                      "Deposit & Charge Preview",
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                // Scrollable List
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          for (final ledger in widget.collectionLedgers)
                            if (ledger.isSelected)
                              InfoRow(collectionLedgerEntity: ledger),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Fixed Bottom Total
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 90,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: colorScheme.primary, width: 1.2),
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(8),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Deposit Total:",
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        TakaFormatter.format(totalAmount),
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Service Charge:",
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        TakaFormatter.format(serviceCharge),
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Grand Total:",
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        TakaFormatter.format(totalAmountWithServiceCharge),
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final CollectionLedgerEntity collectionLedgerEntity;

  const InfoRow({super.key, required this.collectionLedgerEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.theme.colorScheme.primary,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          // Left side: Account Info
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  collectionLedgerEntity.ledgerName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${collectionLedgerEntity.accountNumber.trim()} ${collectionLedgerEntity.plType == 1 ? " - ${collectionLedgerEntity.accountFor.trim()}" : ''}",
                  style: TextStyle(
                    fontSize: 11,
                    color: context.theme.colorScheme.onSurface.withAlpha(180),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (collectionLedgerEntity.plType == 1)
                  Text(
                    collectionLedgerEntity.accountName.trim().toTitleCase(),
                    style: TextStyle(
                      fontSize: 11,
                      color: context.theme.colorScheme.onSurface.withAlpha(180),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),

          // Right side: Amount
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                TakaFormatter.format(collectionLedgerEntity.depositAmount),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: context.theme.colorScheme.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
