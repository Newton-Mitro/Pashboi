import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/extensions/string_casing_extension.dart';
import 'package:pashboi/core/utils/taka_formatter.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_ledger_entity.dart';

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
