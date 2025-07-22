import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:pashboi/core/utils/my_date_utils.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/account_transaction_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_statement_page/widgets/account_statment_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_statement_page/bloc/account_statement_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class AccountStatementPage extends StatelessWidget {
  final String accountNumber;

  const AccountStatementPage({super.key, required this.accountNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account Statement")),
      body: BlocBuilder<AccountStatementBloc, AccountStatementState>(
        builder: (context, accountStatementState) {
          if (accountStatementState is AccountStatementLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (accountStatementState is AccountStatementSuccess) {
            final accountStatement = accountStatementState.transactions;

            return SingleChildScrollView(
              child: Column(
                children: [
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
                      LineSeries<AccountTransactionEntity, String>(
                        name: 'Cash IN',
                        dataSource: accountStatement,
                        xValueMapper:
                            (txn, _) => MyDateUtils.getShortMonthName(txn.date),
                        yValueMapper: (txn, _) => txn.credit,
                        color: Colors.green,
                        markerSettings: const MarkerSettings(isVisible: true),
                      ),
                      LineSeries<AccountTransactionEntity, String>(
                        name: 'Cash OUT',
                        dataSource: accountStatement,
                        xValueMapper:
                            (txn, _) => MyDateUtils.getShortMonthName(txn.date),
                        yValueMapper: (txn, _) => txn.debit,
                        color: Colors.red,
                        markerSettings: const MarkerSettings(isVisible: true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: context.theme.colorScheme.surface,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          "Half Yearly Statement",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                        AccountStatmentSection(
                          accountStatment: accountStatement,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            );
          }

          if (accountStatementState is AccountStatementError) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                accountStatementState.error,
                style: TextStyle(
                  color: context.theme.colorScheme.error,
                  fontSize: 14,
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
