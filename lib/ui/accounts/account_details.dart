import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/ui/accounts/account_statment_list.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:accordion/accordion.dart';

// Transaction data model
class TransactionAmount {
  TransactionAmount(this.month, this.amount);

  final String month;
  final double amount;
}

// Utility function to extract month abbreviation
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

// Sample account + transaction data
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
      "TxnDate": "2024-07-30T10:03:17",
      "Particulars": "RVDC202407300186/4 Cash Collection cash",
      "DepositAmount": 25,
      "WithdrawAmount": 0,
      "Balance": 1054,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
    {
      "TxnDate": "2024-10-23T16:24:17",
      "Particulars": "DVDC202410230029/1 Savings Withdrawal through bkash 2453",
      "DepositAmount": 0,
      "WithdrawAmount": 10,
      "Balance": 1044,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
    {
      "TxnDate": "2024-10-23T16:36:14",
      "Particulars": "DVDC202410230031/1 Savings Withdrawal through bkash 2453",
      "DepositAmount": 0,
      "WithdrawAmount": 12,
      "Balance": 1032,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
    {
      "TxnDate": "2024-11-03T10:18:24",
      "Particulars": "DVDC202411030001/1 Savings Withdrawal through bkash 2453",
      "DepositAmount": 0,
      "WithdrawAmount": 10,
      "Balance": 1022,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
    {
      "TxnDate": "2024-11-03T11:30:27",
      "Particulars": "DVDC202411030002/1 Savings Withdrawal through bkash 2453",
      "DepositAmount": 0,
      "WithdrawAmount": 10,
      "Balance": 1012,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
    {
      "TxnDate": "2024-11-03T12:11:15",
      "Particulars": "DVDC202411030003/1 Savings Withdrawal through bkash 2453",
      "DepositAmount": 0,
      "WithdrawAmount": 10,
      "Balance": 1002,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
    {
      "TxnDate": "2024-11-04T10:45:56",
      "Particulars": "CVDC202411040001/1  cash",
      "DepositAmount": 1000000,
      "WithdrawAmount": 0,
      "Balance": 1001002,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
    {
      "TxnDate": "2024-11-04T10:47:03",
      "Particulars": "DVDC202411040001/1 Savings Withdrawal through bkash 2453",
      "DepositAmount": 0,
      "WithdrawAmount": 1000,
      "Balance": 1000002,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
    {
      "TxnDate": "2024-11-27T12:13:09",
      "Particulars": "JVDC202411270001/1 Transfer MMS Collection Deposit",
      "DepositAmount": 0,
      "WithdrawAmount": 10,
      "Balance": 999992,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
    {
      "TxnDate": "2024-11-27T12:20:42",
      "Particulars": "JVDC202411270002/1 Transfer MMS Collection Deposit",
      "DepositAmount": 0,
      "WithdrawAmount": 20,
      "Balance": 999972,
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
      "DepositAmount": 0,
      "WithdrawAmount": 25,
      "Balance": 999647,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
    {
      "TxnDate": "2025-01-07T15:05:12",
      "Particulars": "JVDC202501070008/1 Transfer Web Transfer",
      "DepositAmount": 0,
      "WithdrawAmount": 10,
      "Balance": 999637,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
    {
      "TxnDate": "2025-01-07T15:05:20",
      "Particulars": "JVDC202501070009/1 Transfer Web Transfer",
      "DepositAmount": 0,
      "WithdrawAmount": 10,
      "Balance": 999627,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
    {
      "TxnDate": "2025-01-07T15:07:12",
      "Particulars": "JVDC202501070010/1 Transfer Web Transfer",
      "DepositAmount": 0,
      "WithdrawAmount": 10,
      "Balance": 999617,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
    {
      "TxnDate": "2025-02-20T17:00:34",
      "Particulars": "JVDC202502200001/1 Transfer MMS Collection Deposit",
      "DepositAmount": 0,
      "WithdrawAmount": 35,
      "Balance": 999582,
      "AccountNo": "T-0063366       ",
      "AccountName": "NEWTON MITRA",
    },
    {
      "TxnDate": "2025-03-22T16:40:40",
      "Particulars": "JVDC202503220001/1 Transfer MMS Collection Deposit",
      "DepositAmount": 0,
      "WithdrawAmount": 25,
      "Balance": 999557,
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

// Parse transaction data
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
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Saving’s Account Details',
              style: TextStyle(
                color: context.theme.colorScheme.surface,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Icon(
              FontAwesomeIcons.house,
              size: 20,
              color: context.theme.colorScheme.surface,
            ),
          ],
        ),
      ),
      body: PageContainer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: context.theme.colorScheme.primary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Account Name",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color:
                                                context
                                                    .theme
                                                    .colorScheme
                                                    .onPrimary,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          accountInfo["AccHolderName"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            color:
                                                context
                                                    .theme
                                                    .colorScheme
                                                    .onPrimary,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Account Number",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color:
                                                context
                                                    .theme
                                                    .colorScheme
                                                    .onPrimary,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          accountInfo['AccountNo'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            color:
                                                context
                                                    .theme
                                                    .colorScheme
                                                    .onPrimary,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Account Balance",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color:
                                                context
                                                    .theme
                                                    .colorScheme
                                                    .onPrimary,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          accountInfo['Balance'].toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            color:
                                                context
                                                    .theme
                                                    .colorScheme
                                                    .onPrimary,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Withdrawable Balance",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color:
                                                context
                                                    .theme
                                                    .colorScheme
                                                    .onPrimary,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          accountInfo['WithdrawableBalance']
                                              .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            color:
                                                context
                                                    .theme
                                                    .colorScheme
                                                    .onPrimary,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "LastDepositDate",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color:
                                                context
                                                    .theme
                                                    .colorScheme
                                                    .onPrimary,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        if (accountData['LastDepositDate'] !=
                                            null)
                                          Text(
                                            formatDate(
                                              accountInfo['LastPaidDate'],
                                            ),
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color:
                                                  context
                                                      .theme
                                                      .colorScheme
                                                      .onPrimary,
                                            ),
                                          )
                                        else
                                          Text(
                                            'No deposit',
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color:
                                                  context
                                                      .theme
                                                      .colorScheme
                                                      .onPrimary,
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
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Half Yearly Transaction Chart",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
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
              const SizedBox(height: 10),
              Column(
                children: [
                  Accordion(
                    paddingListTop: 0,
                    paddingListBottom: 0,
                    maxOpenSections: 1,
                    headerBackgroundColorOpened:
                        context.theme.colorScheme.primary,
                    headerPadding: const EdgeInsets.symmetric(
                      vertical: 7,
                      horizontal: 15,
                    ),
                    children: [
                      AccordionSection(
                        isOpen: false,
                        leftIcon: const Icon(
                          FontAwesomeIcons.filePdf,
                          color: Colors.white,
                        ),
                        headerBackgroundColor:
                            context.theme.colorScheme.primary,
                        headerBackgroundColorOpened:
                            context.theme.colorScheme.primary,
                        header: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'View Statement',
                              style: TextStyle(
                                color: context.theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                        content: Column(
                          children: [
                            AccountStatmentList(accountStatment: accountData),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: context.theme.colorScheme.primary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Current Balance - ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.onPrimary,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            2.0,
                                          ),
                                          color:
                                              context.theme.colorScheme.surface,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                accountInfo["Balance"],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      Theme.of(
                                                        context,
                                                      ).colorScheme.onSurface,
                                                ),
                                              ),
                                              SizedBox(width: 4),
                                              Icon(
                                                FontAwesomeIcons
                                                    .bangladeshiTakaSign,
                                                size: 15,
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.onSurface,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        contentBorderColor: context.theme.colorScheme.onPrimary,
                      ),
                    ],
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
