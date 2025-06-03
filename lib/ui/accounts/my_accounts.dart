import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/ui/accounts/account_list_wiget.dart';
import 'package:pashboi/ui/new_widget/account_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyAccounts extends StatefulWidget {
  const MyAccounts({super.key});

  @override
  State<MyAccounts> createState() => _MyAccountsState();
}

final List<Map<String, dynamic>> accountMapList = [
  {
    "accountName": "saving account",
    "accountShortName": "SAV",
    "accountNo": "T-1234567890",
    "amount": "25000",
    "isDefaulter": true,
  },
  {
    "accountName": "TSP account",
    "accountShortName": "TSP",
    "accountNo": "T-0987654321",
    "amount": "3056",
  },
  {
    "accountName": "STD account",
    "accountShortName": "STD",
    "accountNo": "T-1122334455",
    "amount": "2000",
  },
  {
    "accountName": "Health Care Scame",
    "accountShortName": "HSC",
    "accountNo": "HCS-5820",
    "amount": "7000",
    "isDefaulter": true,
  },
  {
    "accountName": "Fixed Deposit",
    "accountShortName": "FD",
    "accountNo": "FD_5825",
    "amount": "15000",
  },
];

// Convert map list to AccountData list:
final List<AccountData> accountList =
    accountMapList
        .map((accountMap) => AccountData.fromMap(accountMap))
        .toList();

class AccountData {
  AccountData(
    this.accountName,
    this.accountShortName,
    this.accountNumber,
    this.amount, {
    this.isDefaulter = false,
  });

  final String accountName;
  final String accountShortName;
  final String accountNumber;
  final double amount;
  final bool isDefaulter;

  factory AccountData.fromMap(Map<String, dynamic> map) {
    return AccountData(
      map['accountName'] ?? '',
      map['accountShortName'] ?? '',
      map['accountNo'] ?? '',
      double.tryParse(map['amount']?.toString() ?? '0') ?? 0,
      isDefaulter: map['isDefaulter'] ?? false,
    );
  }
}

class _MyAccountsState extends State<MyAccounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Accounts',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: SingleChildScrollView(
            // Add this
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(
                              8.0,
                            ), // inner padding for text
                            decoration: BoxDecoration(
                              // 👈 set your background color here
                              borderRadius: BorderRadius.circular(
                                6.0,
                              ), // optional rounded corners
                            ),
                            child: Center(
                              child: Text(
                                "Account balance chart",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black, // text color
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(right: 15, bottom: 5),
                            child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              backgroundColor: Colors.transparent,
                              legend: Legend(isVisible: true),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <CartesianSeries<AccountData, String>>[
                                BarSeries<AccountData, String>(
                                  dataSource: accountList,
                                  xValueMapper:
                                      (AccountData data, _) =>
                                          data.accountShortName,
                                  yValueMapper:
                                      (AccountData data, _) => data.amount,
                                  name: 'Amount',
                                  dataLabelMapper:
                                      (AccountData data, _) =>
                                          data.amount.toString(),
                                  dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                    Column(
                      children:
                          accountList.map((account) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: AccountCard(
                                icon: FontAwesomeIcons.piggyBank,
                                isDefaulter: account.isDefaulter,
                                child: AccountListWiget(
                                  accountName: account.accountName,
                                  accountNumber: account.accountNumber,
                                  icon: FontAwesomeIcons.angleRight,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
