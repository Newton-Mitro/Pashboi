import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class AccountStatmentList extends StatefulWidget {
  const AccountStatmentList({super.key, required this.accountStatment});

  final Map<String, dynamic> accountStatment;

  @override
  State<AccountStatmentList> createState() => _AccountStatmentListState();
}

String formatDate(String inputDate, {String format = 'full'}) {
  final date = DateTime.parse(inputDate);

  switch (format) {
    case 'day':
      return DateFormat('dd').format(date);
    case 'month':
      return DateFormat('MMM').format(date); // Or 'MM' for numeric month
    case 'year':
      return DateFormat('yyyy').format(date);
    default:
      return DateFormat('dd-MMM-yyyy').format(date); // full by default
  }
}

class _AccountStatmentListState extends State<AccountStatmentList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              height: 300,
              child: SingleChildScrollView(
                child: Column(
                  spacing: 8,
                  children: [
                    const SizedBox(height: 8),
                    ...List.generate(
                      widget.accountStatment['Transactions'].length,
                      (index) {
                        final txn =
                            widget.accountStatment['Transactions'][index];
                        final date = txn['TxnDate'].toString().split('T')[0];
                        final deposit = txn['DepositAmount'];
                        final withdraw = txn['WithdrawAmount'];
                        final balance = txn['Balance']?.toString() ?? '0.00';

                        final amount =
                            deposit > 0 ? '+${deposit}' : '-${withdraw}';
                        return Row(
                          spacing: 4,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
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
                                        fontSize: 20,
                                        color:
                                            context.theme.colorScheme.onPrimary,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          formatDate(date, format: 'month'),
                                          style: TextStyle(
                                            fontSize: 8,
                                            color:
                                                context
                                                    .theme
                                                    .colorScheme
                                                    .onPrimary,
                                          ),
                                        ),
                                        Text(
                                          formatDate(date, format: 'year'),
                                          style: TextStyle(
                                            fontSize: 8,
                                            color:
                                                context
                                                    .theme
                                                    .colorScheme
                                                    .onPrimary,
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
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  (deposit == 0 && withdraw == 0)
                                      ? SizedBox() // Or Container()
                                      : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            amount,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Icon(
                                            FontAwesomeIcons
                                                .bangladeshiTakaSign,
                                            size: 10,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.onSurface,
                                          ),
                                        ],
                                      ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '=$balance',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
