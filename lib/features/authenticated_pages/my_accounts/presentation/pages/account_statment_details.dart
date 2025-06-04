import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/utils/taka_formatter.dart';

class AccountStatmentDetails extends StatefulWidget {
  const AccountStatmentDetails({super.key, required this.accountStatment});

  final Map<String, dynamic> accountStatment;

  @override
  State<AccountStatmentDetails> createState() => _AccountStatmentDetailsState();
}

String formatDate(String inputDate, {String format = 'full'}) {
  final date = DateTime.parse(inputDate);

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

class _AccountStatmentDetailsState extends State<AccountStatmentDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
      child: Column(
        spacing: 10,
        children: [
          ...List.generate(widget.accountStatment['Transactions'].length, (
            index,
          ) {
            final txn = widget.accountStatment['Transactions'][index];
            final date = txn['TxnDate'].toString().split('T')[0];
            final deposit = txn['DepositAmount'];
            final withdraw = txn['WithdrawAmount'];
            final balance = txn['Balance']?.toString() ?? '0.00';
            var amount = '';
            if (deposit == 0 && withdraw == 0) {
              amount = balance;
            } else {
              amount = deposit > 0 ? '+${deposit}' : '-${withdraw}';
            }

            return Row(
              spacing: 10,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.all(2.0),
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
                        Column(
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
                Expanded(
                  flex: 7,
                  child: Text(
                    txn['Particulars'],
                    style: TextStyle(
                      fontSize: 12,
                      color: context.theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            TakaFormatter.format(int.parse(amount)),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '=${TakaFormatter.format(int.parse(balance))}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 11,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
