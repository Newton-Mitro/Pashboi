import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/extensions/string_casing_extension.dart';
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
  "IsDefaulter": true,
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

String formatDate(String inputDate) {
  DateTime date = DateTime.parse(inputDate);
  return DateFormat('dd-MMM-yyyy').format(date);
}

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({super.key});
  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  Widget buildInfoRow(
    BuildContext context,
    String title,
    String value, {
    IconData icon = Icons.info_outline,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Icon(icon, size: 20, color: colorScheme.onSurface),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    color: colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Details')),
      body: PageContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: context.theme.colorScheme.primary,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      FontAwesomeIcons.solidCircleUser,
                      size: 60,
                      color: context.theme.colorScheme.onSurface,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      accountInfo["AccHolderName"].toString().toTitleCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      accountInfo["AccountTypeName"].toString().toTitleCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      accountInfo["AccountNo"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      children: [
                        Chip(
                          label: Text(
                            accountInfo["STATUS"] ?? "Unknown",
                            style: TextStyle(
                              fontSize: 12,
                              color: context.theme.colorScheme.onSecondary,
                            ),
                          ),
                          backgroundColor: context.theme.colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(
                            color: context.theme.colorScheme.secondary,
                            width: 1,
                          ),
                          visualDensity: VisualDensity.compact,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                        Chip(
                          label: Text(
                            (accountInfo["IsDefaulter"] as bool)
                                ? "Defaulter"
                                : "Regular",
                            style: TextStyle(
                              fontSize: 12,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                          backgroundColor:
                              (accountInfo["IsDefaulter"] as bool)
                                  ? context.theme.colorScheme.error
                                  : context.theme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(
                            color:
                                (accountInfo["IsDefaulter"] as bool)
                                    ? context.theme.colorScheme.error
                                    : context.theme.colorScheme.primary,
                            width: 1,
                          ),
                          visualDensity: VisualDensity.compact,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.theme.colorScheme.secondary,
                      border: Border.all(
                        color: context.theme.colorScheme.onSecondary,
                        width: 6,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Available Balance",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          TakaFormatter.format(
                            int.tryParse(accountInfo["Balance"] ?? '0') ?? 0,
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.theme.colorScheme.primary,
                      border: Border.all(
                        color: context.theme.colorScheme.onPrimary,
                        width: 6,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Withdrawable Balance",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          TakaFormatter.format(
                            int.tryParse(
                                  accountInfo["WithdrawableBalance"] ?? '0',
                                ) ??
                                0,
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              buildInfoRow(
                context,
                "Last Deposit Date",
                accountInfo["LastPaidDate"] != null
                    ? formatDate(accountInfo["LastPaidDate"])
                    : 'No deposit',
                icon: FontAwesomeIcons.calendarCheck,
              ),
              buildInfoRow(
                context,
                "Maturity Date",
                formatDate(accountInfo["MaturityDate"]),
                icon: FontAwesomeIcons.hourglassEnd,
              ),
              buildInfoRow(
                context,
                "Nominee",
                accountInfo["AccountNominee"].toString().toTitleCase(),
                icon: FontAwesomeIcons.userShield,
              ),
              const SizedBox(height: 20),
              SfCartesianChart(
                title: ChartTitle(
                  text: 'Half Yearly Transactions',
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.top,
                  overflowMode: LegendItemOverflowMode.wrap,
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(),
                series: <CartesianSeries>[
                  LineSeries<TransactionAmount, String>(
                    name: 'Cash IN',
                    dataSource: depositTransactionData,
                    xValueMapper: (txn, _) => txn.month,
                    yValueMapper: (txn, _) => txn.amount,
                    color: Colors.green,
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                  LineSeries<TransactionAmount, String>(
                    name: 'Cash OUT',
                    dataSource: withdrawTransactionData,
                    xValueMapper: (txn, _) => txn.month,
                    yValueMapper: (txn, _) => txn.amount,
                    color: Colors.red,
                    markerSettings: const MarkerSettings(isVisible: true),
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
