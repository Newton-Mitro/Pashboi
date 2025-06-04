import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/app_icon_card.dart';
import 'package:pashboi/features/authenticated_pages/my_accounts/presentation/pages/account_card_body.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// Account data model
class AccountData {
  final String accountName;
  final String accountShortName;
  final String accountNumber;
  final double balance;
  final bool isDefaulter;

  AccountData({
    required this.accountName,
    required this.accountShortName,
    required this.accountNumber,
    required this.balance,
    required this.isDefaulter,
  });
}

// Raw map data
final List<Map<String, dynamic>> accountMapList = [
  {
    "accountName": "Saving Account",
    "accountShortName": "SAV",
    "accountNo": "T-1234567890",
    "balance": "25000",
    "isDefaulter": true,
  },
  {
    "accountName": "TSP Account",
    "accountShortName": "TSP",
    "accountNo": "T-0987654321",
    "balance": "3056",
    "isDefaulter": false,
  },
  {
    "accountName": "STD Account",
    "accountShortName": "STD",
    "accountNo": "T-1122334455",
    "balance": "2000",
    "isDefaulter": false,
  },
  {
    "accountName": "Health Care Scheme",
    "accountShortName": "HSC",
    "accountNo": "HCS-5820",
    "balance": "7000",
    "isDefaulter": true,
  },
  {
    "accountName": "Fixed Deposit",
    "accountShortName": "FD",
    "accountNo": "FD_5825",
    "balance": "15000",
    "isDefaulter": false,
  },
];

// Converted account list
final List<AccountData> accountList =
    accountMapList
        .map(
          (map) => AccountData(
            accountName: map["accountName"],
            accountShortName: map["accountShortName"],
            accountNumber: map["accountNo"],
            balance: double.tryParse(map["balance"]) ?? 0,
            isDefaulter: map["isDefaulter"],
          ),
        )
        .toList();

class MyAccountsPage extends StatefulWidget {
  const MyAccountsPage({super.key});

  @override
  State<MyAccountsPage> createState() => _MyAccountsPageState();
}

class _MyAccountsPageState extends State<MyAccountsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Accounts')),
      body: PageContainer(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Chart Section
              Column(
                children: [
                  Center(
                    child: Text(
                      "Accounts Summary",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: context.theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    backgroundColor: Colors.transparent,
                    legend: Legend(isVisible: true),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CartesianSeries<AccountData, String>>[
                      BarSeries<AccountData, String>(
                        dataSource: accountList,
                        xValueMapper: (data, _) => data.accountShortName,
                        yValueMapper: (data, _) => data.balance,
                        name: 'Amount',
                        dataLabelMapper:
                            (data, _) => data.balance.toStringAsFixed(0),
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Account Cards List
              Column(
                children:
                    accountList.map((account) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: AppIconCard(
                          leftIcon: FontAwesomeIcons.piggyBank,
                          boarderColor:
                              account.isDefaulter
                                  ? context.theme.colorScheme.primary
                                  : context.theme.colorScheme.error,
                          cardBody: AccountCardBody(
                            accountName: account.accountName,
                            accountNumber: account.accountNumber,
                            icon: FontAwesomeIcons.angleRight,
                          ),
                          onTap: () {
                            print("object");
                          },
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
