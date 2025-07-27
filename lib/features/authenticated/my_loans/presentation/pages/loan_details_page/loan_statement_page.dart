import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/utils/my_date_utils.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/entities/loan_transaction_entity.dart';
import 'package:pashboi/features/authenticated/my_loans/presentation/pages/loan_statement_section/bloc/loan_statement_bloc.dart';
import 'package:pashboi/features/authenticated/my_loans/presentation/pages/loan_statement_section/loan_statment_section.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LoanStatementPage extends StatelessWidget {
  final String loanNumber;

  const LoanStatementPage({super.key, required this.loanNumber});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              sl<LoanStatementBloc>()
                ..add(FetchLoanStatementEvent(loanNumber: loanNumber)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Loan Statement')),
        body: BlocBuilder<LoanStatementBloc, LoanStatementState>(
          builder: (context, loanStatement) {
            if (loanStatement is LoanStatementLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (loanStatement is LoanStatementSuccess) {
              final transactions = loanStatement.transactions;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SfCartesianChart(
                      title: ChartTitle(
                        text: 'Transactions Graph',
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
                        LineSeries<LoanTransactionEntity, String>(
                          name: 'Loan Issued',
                          dataSource: transactions,
                          xValueMapper:
                              (txn, _) => MyDateUtils.getShortMonthName(
                                txn.transactionDate,
                              ),
                          yValueMapper: (txn, _) => txn.creditAmount,
                          color: Colors.green,
                          markerSettings: const MarkerSettings(isVisible: true),
                        ),
                        LineSeries<LoanTransactionEntity, String>(
                          name: 'Loan Repaid',
                          dataSource: transactions,
                          xValueMapper:
                              (txn, _) => MyDateUtils.getShortMonthName(
                                txn.transactionDate,
                              ),
                          yValueMapper: (txn, _) => txn.debitAmount,
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
                            "Statement",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                          LoanStatmentSection(loanStatement: transactions),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              );
            }

            if (loanStatement is LoanStatementError) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  loanStatement.error,
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
      ),
    );
  }
}
