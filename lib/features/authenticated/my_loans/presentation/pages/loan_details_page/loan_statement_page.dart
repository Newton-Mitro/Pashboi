import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/utils/my_date_utils.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/entities/loan_transaction_entity.dart';
import 'package:pashboi/features/authenticated/my_loans/presentation/pages/loan_statement_section/bloc/loan_statement_bloc.dart';
import 'package:pashboi/features/authenticated/my_loans/presentation/pages/loan_statement_section/loan_statment_section.dart';
import 'package:pashboi/shared/widgets/app_date_picker.dart';
import 'package:pashboi/shared/widgets/buttons/app_secondary_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LoanStatementPage extends StatefulWidget {
  final String loanNumber;

  const LoanStatementPage({super.key, required this.loanNumber});

  @override
  State<LoanStatementPage> createState() => _LoanStatementPageState();
}

class _LoanStatementPageState extends State<LoanStatementPage> {
  late DateTime startDate;
  late DateTime endDate;
  String? _errorText;

  @override
  void initState() {
    endDate = DateTime.now();
    startDate = DateTime(endDate.year, endDate.month - 3, endDate.day);

    context.read<LoanStatementBloc>().add(
      FetchLoanStatementEvent(
        loanNumber: widget.loanNumber,
        fromDate: "${startDate.year}/${startDate.month}/${startDate.day}",
        toDate: "${endDate.year}/${endDate.month}/${endDate.day}",
      ),
    );
    super.initState();
  }

  void _handleDateChange(DateTime date, {required bool isFromDate}) {
    setState(() {
      if (isFromDate) {
        startDate = date;
      } else {
        endDate = date;
      }

      if (endDate.isBefore(startDate)) {
        _errorText = 'To Date must be after From Date';
      } else {
        _errorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Locales.string(context, 'loan_statement'))),
      body: BlocBuilder<LoanStatementBloc, LoanStatementState>(
        builder: (context, loanStatement) {
          if (loanStatement is LoanStatementLoading) {
            return const Center(child: CircularProgressIndicator());
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

          if (loanStatement is LoanStatementSuccess) {
            final transactions = loanStatement.transactions;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: AppDatePicker(
                                selectedDate: startDate,
                                onDateChanged:
                                    (d) =>
                                        _handleDateChange(d!, isFromDate: true),
                                label: 'From Date',
                                errorText: _errorText,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: AppDatePicker(
                                selectedDate: endDate,
                                onDateChanged:
                                    (d) => _handleDateChange(
                                      d!,
                                      isFromDate: false,
                                    ),
                                label: 'To Date',
                                errorText: _errorText,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        AppSecondaryButton(
                          label: "",
                          iconBefore: const Icon(Icons.filter_alt),
                          onPressed: () {
                            if (_errorText == null) {
                              context.read<LoanStatementBloc>().add(
                                FetchLoanStatementEvent(
                                  loanNumber: widget.loanNumber,
                                  fromDate:
                                      "${startDate.year}/${startDate.month}/${startDate.day}",
                                  toDate:
                                      "${endDate.year}/${endDate.month}/${endDate.day}",
                                ),
                              );
                            } else {
                              setState(() {
                                _errorText ??= 'Please select valid dates.';
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SfCartesianChart(
                    title: ChartTitle(
                      text: Locales.string(context, 'transaction_graph'),
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
                        name: Locales.string(context, 'loan_issued'),
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
                        name: Locales.string(context, 'loan_repaid'),
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
                          Locales.string(context, 'statement'),
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

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
