import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/utils/taka_formatter.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/account_transaction_entity.dart';

class AccountStatmentSection extends StatefulWidget {
  const AccountStatmentSection({super.key, required this.accountStatment});

  final List<AccountTransactionEntity> accountStatment;

  @override
  State<AccountStatmentSection> createState() => _AccountStatmentSectionState();
}

String formatDate(DateTime date, {String format = 'full'}) {
  switch (format) {
    case 'day':
      return DateFormat('dd').format(date);
    case 'month':
      return DateFormat('MMM').format(date);
    case 'year':
      return DateFormat('yyyy').format(date);
    default:
      return DateFormat('dd-MMM-yyyy').format(date);
  }
}

class _AccountStatmentSectionState extends State<AccountStatmentSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      child: Column(
        children: [
          ...widget.accountStatment.map((txn) {
            final date = txn.date;
            final deposit = txn.credit;
            final withdraw = txn.debit;
            final balance = txn.balance;
            final isCredit = deposit > 0;
            final amount = isCredit ? deposit : -withdraw;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: context.theme.colorScheme.primary,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            formatDate(date, format: 'day'),
                            style: TextStyle(
                              fontSize: 24,
                              color: context.theme.colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formatDate(date, format: 'month'),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: context.theme.colorScheme.onPrimary,
                                ),
                              ),
                              Text(
                                formatDate(date, format: 'year'),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: context.theme.colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 7,
                    child: Text(
                      txn.particular,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          TakaFormatter.format(amount),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          '=${TakaFormatter.format(balance)}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 11,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
