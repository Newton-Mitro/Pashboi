import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/utils/taka_formatter.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_statment_details.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:accordion/accordion.dart';

class TransactionAmount {
  TransactionAmount(this.month, this.amount);

  final String month;
  final double amount;
}

String monthName(String dateStr) {
  DateTime date = DateTime.parse(dateStr);
  return DateFormat.MMM().format(date);
}

final Map<String, dynamic> accountInfo = {
  "AccountNo": "DDS-0058818",
  "DCAccountNo": "DDS-0058818",
  "AccHolderName": "BAPPY BESRA",
  "AccountTypeName": "Double Deposit Scheme Project",
  "Balance": "1000000",
  "WithdrawableBalance": "0",
  "LoanBalance": 0,
  "STATUS": "Active",
  "LastPaidDate": "2023-05-23T12:31:00",
  "AccountNominee": "SUJAN DOMINIC GOMES ",
  "PendingTotalDepositAmount": 4005,
  "PendingTotalDepositRequest": 37,
  "PendingTotalTransferAmount": 0,
  "PendingTotalTransferRequest": 0,
  "AccountId": 293908,
  "LedgerId": 1500,
  "MaturityDate": "2031-05-22T12:42:25.71",
  "AccountTypeCode": 30,
  "IsDefaulter": "",
};

final Map<String, dynamic> accountData = {
  "Transactions": [
    {
      "TxnDate": "2024-07-01T00:00:00",
      "Particulars": "B/F               ",
      "DepositAmount": 0,
      "WithdrawAmount": 0,
      "Balance": 1029,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
    {
      "TxnDate": "2025-01-07T15:02:05",
      "Particulars": "JVDC202501070006/1 Transfer Deposit from Saving Accounts",
      "DepositAmount": 0,
      "WithdrawAmount": 300,
      "Balance": 999672,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
    {
      "TxnDate": "2025-01-07T15:03:26",
      "Particulars": "JVDC202501070007/1 Transfer MMS Collection Deposit",
      "DepositAmount": 10000,
      "WithdrawAmount": 0,
      "Balance": 999647,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
    {
      "TxnDate": "2025-03-23T16:54:21",
      "Particulars": "JVDC202503230003/1 Transfer Web Transfer",
      "DepositAmount": 0,
      "WithdrawAmount": 10,
      "Balance": 999547,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
  ],
};

final List<TransactionAmount> depositTransactionData =
    (accountData['Transactions'] as List<dynamic>)
        .map(
          (e) => TransactionAmount(
            monthName(e['TxnDate']),
            (e['DepositAmount'] ?? 0.0).toDouble(),
          ),
        )
        .toList();

final List<TransactionAmount> withdrawTransactionData =
    (accountData['Transactions'] as List<dynamic>)
        .map(
          (e) => TransactionAmount(
            monthName(e['TxnDate']),
            (e['WithdrawAmount'] ?? 0.0).toDouble(),
          ),
        )
        .toList();

class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key});

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

String formatDate(String inputDate) {
  DateTime date = DateTime.parse(inputDate);
  return DateFormat('dd-MMM-yyyy').format(date);
}

class _AccountDetailsState extends State<AccountDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account Details')),
      body: PageContainer(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: context.theme.colorScheme.surface,
                ),
                child: Column(
                  spacing: 15,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Account Name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: context.theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  accountInfo["AccHolderName"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: context.theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Account Number",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: context.theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  accountInfo['AccountNo'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: context.theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Account Balance",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: context.theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  TakaFormatter.format(
                                    int.parse(accountInfo['Balance']),
                                  ),
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: context.theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Withdrawable Balance",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: context.theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  accountInfo['WithdrawableBalance'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: context.theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "LastDepositDate",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: context.theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (accountData['LastDepositDate'] != null)
                                  Text(
                                    formatDate(accountInfo['LastPaidDate']),
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color:
                                          context.theme.colorScheme.onPrimary,
                                    ),
                                  )
                                else
                                  Text(
                                    'No deposit',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color:
                                          context.theme.colorScheme.onPrimary,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Half Yearly Transactions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: context.theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(title: AxisTitle(text: '')),
                    primaryYAxis: NumericAxis(title: AxisTitle(text: '')),
                    backgroundColor: Colors.transparent,
                    legend: Legend(isVisible: true),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CartesianSeries<TransactionAmount, String>>[
                      LineSeries<TransactionAmount, String>(
                        color: Colors.green,
                        dataSource: depositTransactionData,
                        xValueMapper: (txn, _) => txn.month,
                        yValueMapper: (txn, _) => txn.amount,
                        name: 'Cash IN',
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ),
                      ),
                      LineSeries<TransactionAmount, String>(
                        color: Colors.red,
                        dataSource: withdrawTransactionData,
                        xValueMapper: (txn, _) => txn.month,
                        yValueMapper: (txn, _) => txn.amount,
                        name: 'Cash OUT',
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Accordion(
                headerBackgroundColorOpened: context.theme.colorScheme.primary,
                headerPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                children: [
                  AccordionSection(
                    isOpen: true,
                    leftIcon: const Icon(FontAwesomeIcons.fileContract),
                    headerBackgroundColor: context.theme.colorScheme.primary,
                    contentBackgroundColor: context.theme.colorScheme.surface,
                    headerBackgroundColorOpened:
                        context.theme.colorScheme.primary,
                    contentBorderColor: context.theme.colorScheme.primary,
                    contentHorizontalPadding: 0,
                    contentVerticalPadding: 0,
                    header: Text(
                      'Account Statement',
                      textAlign: TextAlign.left,
                    ),
                    content: Column(
                      children: [
                        AccountStatmentDetails(accountStatment: accountData),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
