import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/extensions/string_casing_extension.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_ledger_entity.dart';

class TransactionDetailsSection extends StatefulWidget {
  const TransactionDetailsSection({super.key, required this.collectionLedgers});

  final List<CollectionLedgerEntity> collectionLedgers;

  @override
  State<TransactionDetailsSection> createState() =>
      _TransactionDetailsSectionState();
}

class _TransactionDetailsSectionState extends State<TransactionDetailsSection> {
  final Map<String, bool> selectedLedgers = {};
  final Map<String, String> inputAmounts = {};

  @override
  void initState() {
    super.initState();
    for (var ledger in widget.collectionLedgers) {
      final accountId = ledger.ledgerId.toString();
      selectedLedgers[accountId] = false;
      inputAmounts[ledger.accountNumber] = '';
    }
  }

  bool get areAllSelected =>
      selectedLedgers.isNotEmpty &&
      selectedLedgers.values.every((isSelected) => isSelected);

  void _toggleSelectAll(bool select) {
    setState(() {
      for (var ledger in widget.collectionLedgers) {
        selectedLedgers[ledger.ledgerId.toString()] = select;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildNomineeSelectionCard(context);
  }

  Widget _buildNomineeSelectionCard(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        border: Border.all(color: context.theme.colorScheme.primary),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Sticky header
          _buildHeader(context, "Select Deposit Accounts"),

          // ✅ Scrollable list only
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                50,
              ), // 👈 extra bottom space
              child: Column(
                children:
                    widget.collectionLedgers.map((ledger) {
                      final accountId = ledger.ledgerId.toString();

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: selectedLedgers[accountId] ?? false,
                              onChanged: (value) {
                                setState(() {
                                  selectedLedgers[accountId] = value!;
                                });
                              },
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ledger.ledgerName.trim(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (ledger.plType == 1)
                                    Text(
                                      "${ledger.accountNumber.trim()} (${ledger.accountFor.trim()})",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  if (ledger.plType == 1)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        ledger.accountName.toTitleCase().trim(),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 110,
                              height: 36,
                              child: TextFormField(
                                enabled: selectedLedgers[accountId] ?? false,
                                decoration: const InputDecoration(
                                  labelText: "Amt",
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 8,
                                  ),
                                ),
                                style: TextStyle(fontSize: 13),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    inputAmounts[accountId] = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: context.theme.colorScheme.onPrimary,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton.icon(
            onPressed: () {
              _toggleSelectAll(!areAllSelected);
            },
            icon: Icon(
              areAllSelected ? Icons.remove_done : Icons.done_all,
              color: context.theme.colorScheme.onPrimary,
            ),
            label: Text(
              areAllSelected ? "Deselect All" : "Select All",
              style: TextStyle(
                color: context.theme.colorScheme.onPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
