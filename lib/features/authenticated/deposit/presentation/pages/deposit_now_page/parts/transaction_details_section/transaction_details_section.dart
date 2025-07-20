import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/extensions/string_casing_extension.dart';
import 'package:pashboi/core/utils/taka_formatter.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/domain/entities/collection_ledger_entity.dart';
import 'package:pashboi/features/authenticated/loan_payment/presentation/pages/bloc/loan_payment_bloc.dart';

class TransactionDetailsSection extends StatelessWidget {
  const TransactionDetailsSection({
    super.key,
    required this.ledgers,
    required this.onToggleSelect,
    required this.onToggleSelectAll,
    required this.onAmountChanged,
    this.sectionError,
    this.amountErrors = const {},
  });

  final List<CollectionLedgerEntity> ledgers;
  final void Function(CollectionLedgerEntity) onToggleSelect;
  final void Function(bool selectAll) onToggleSelectAll;
  final void Function(CollectionLedgerEntity, double) onAmountChanged;
  final String? sectionError;
  final Map<String, String>? amountErrors;

  bool get areAllSelected =>
      ledgers.isNotEmpty && ledgers.every((l) => l.isSelected);

  double get selectedTotal => ledgers
      .where((l) => l.isSelected)
      .fold(0.0, (sum, l) => sum + l.depositAmount);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        border: Border.all(color: context.theme.colorScheme.primary),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, "Accounts to Deposit"),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 47,
                  ), // space for footer
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(8, 16, 16, 40),
                    child: Column(
                      children:
                          ledgers.map((ledger) {
                            final isSelected = ledger.isSelected;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,

                                    children: [
                                      Container(
                                        width: 45,
                                        height: 45,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color:
                                              isSelected
                                                  ? context
                                                      .theme
                                                      .colorScheme
                                                      .primary
                                                  : context
                                                      .theme
                                                      .colorScheme
                                                      .surface,
                                          border: Border.all(
                                            color: context
                                                .theme
                                                .colorScheme
                                                .onSurface
                                                .withAlpha(360),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            60,
                                          ),
                                        ),
                                        margin: const EdgeInsets.all(4),
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(
                                            60,
                                          ),
                                          onTap: () => onToggleSelect(ledger),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Icon(
                                              isSelected
                                                  ? Icons.check
                                                  : Icons.close,
                                              color:
                                                  isSelected
                                                      ? context
                                                          .theme
                                                          .colorScheme
                                                          .onPrimary
                                                      : context
                                                          .theme
                                                          .colorScheme
                                                          .onSurface,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),

                                      // Ledger info
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ledger.ledgerName.trim(),
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "${ledger.accountNumber.trim()} ${ledger.plType == 1 ? " - ${ledger.accountFor.trim()}" : ''}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: context
                                                    .theme
                                                    .colorScheme
                                                    .onSurface
                                                    .withAlpha(180),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            if (ledger.plType == 1)
                                              Text(
                                                ledger.accountName
                                                    .toTitleCase()
                                                    .trim(),
                                                style: TextStyle(
                                                  color: context
                                                      .theme
                                                      .colorScheme
                                                      .onSurface
                                                      .withAlpha(180),
                                                  fontSize: 12,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),

                                      // Amount input
                                      SizedBox(
                                        width: 105,
                                        height: 36,
                                        child: TextFormField(
                                          enabled:
                                              isSelected && !ledger.editable,

                                          initialValue:
                                              ledger.depositAmount.toString(),
                                          decoration: InputDecoration(
                                            labelText: "Amt",
                                            border: OutlineInputBorder(),
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 8,
                                                ),
                                          ),
                                          style: const TextStyle(fontSize: 13),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            final amount =
                                                double.tryParse(value) ?? 0.0;
                                            onAmountChanged(ledger, amount);
                                            if (amount > 0 &&
                                                ledger.lps &&
                                                !ledger.subledger &&
                                                ledger.plType == 2) {
                                              context
                                                  .read<LoanPaymentBloc>()
                                                  .add(
                                                    FetchLoanPayment(
                                                      interestDays: 0,
                                                      interestRate:
                                                          ledger.intrestRate,
                                                      loanBalance:
                                                          ledger.loanBalance,
                                                      loanRefundAmount:
                                                          ledger.depositAmount,
                                                      moduleCode:
                                                          ledger
                                                              .accountTypeCode,
                                                      issuedDate: '',
                                                      lastPaidDate:
                                                          ledger.lastPaidDate
                                                              .toIso8601String(),
                                                    ),
                                                  );
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  amountErrors?[ledger.ledgerId.toString()] !=
                                          null
                                      ? Text(
                                        amountErrors![ledger.ledgerId
                                            .toString()]!,
                                        style: TextStyle(
                                          color:
                                              context.theme.colorScheme.error,
                                          fontSize: 12,
                                        ),
                                      )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Fixed total amount bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 🔻 Optional: Error Text
                if (sectionError?.isNotEmpty ?? false)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.error.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                    ),
                    child: Text(
                      sectionError!,
                      style: TextStyle(
                        color: context.theme.colorScheme.error,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                // 🔻 Total Bar
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: context.theme.colorScheme.primary,
                        width: 1.2,
                      ),
                    ),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Deposit Amount:",
                        style: TextStyle(
                          color: context.theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        TakaFormatter.format(selectedTotal),
                        style: TextStyle(
                          color: context.theme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 45,
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    areAllSelected
                        ? context.theme.colorScheme.error.withAlpha(360)
                        : context.theme.colorScheme.surfaceContainer,
                border: Border.all(
                  color:
                      areAllSelected
                          ? context.theme.colorScheme.onPrimary.withAlpha(360)
                          : context.theme.colorScheme.outlineVariant.withAlpha(
                            360,
                          ),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(60),
              ),
              margin: const EdgeInsets.all(4),
              child: InkWell(
                borderRadius: BorderRadius.circular(60),
                onTap: () => onToggleSelectAll(!areAllSelected),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    areAllSelected ? Icons.remove_done : Icons.done_all,
                    color:
                        areAllSelected
                            ? context.theme.colorScheme.onPrimary
                            : context.theme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ),
              ),
            ),

            Text(
              title,
              style: TextStyle(
                color: context.theme.colorScheme.onPrimary,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 45),
          ],
        ),
      ),
    );
  }
}
