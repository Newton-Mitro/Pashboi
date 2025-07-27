import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_statement_page/bloc/account_statement_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_statement_page/widgets/account_statment_section.dart';
import 'package:pashboi/shared/widgets/app_date_picker.dart';
import 'package:pashboi/shared/widgets/buttons/app_secondary_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:pashboi/core/utils/my_date_utils.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/account_transaction_entity.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class AccountStatementPage extends StatefulWidget {
  final String accountNumber;
  const AccountStatementPage({super.key, required this.accountNumber});

  @override
  State<AccountStatementPage> createState() => _AccountStatementPageState();
}

class _AccountStatementPageState extends State<AccountStatementPage> {
  late DateTime startDate;
  late DateTime endDate;
  String? _errorText;

  @override
  void initState() {
    endDate = DateTime.now();
    startDate = DateTime(endDate.year, endDate.month - 3, endDate.day);

    context.read<AccountStatementBloc>().add(
      FetchAccountStatementEvent(
        accountNumber: widget.accountNumber,
        fromDate: "${startDate.year}/${startDate.month}/${startDate.day}",
        toDate: "${endDate.month}/${endDate.year}/${endDate.day}",
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
      appBar: AppBar(title: Text(Locales.string(context, 'account_statement'))),
      body: BlocBuilder<AccountStatementBloc, AccountStatementState>(
        builder: (context, state) {
          if (state is AccountStatementLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AccountStatementError) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                state.error,
                style: TextStyle(
                  color: context.theme.colorScheme.error,
                  fontSize: 14,
                ),
              ),
            );
          }

          if (state is AccountStatementSuccess) {
            final transactions = state.transactions;

            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildDatePickers(),
                  const SizedBox(height: 20),
                  _buildChart(transactions),
                  const SizedBox(height: 20),
                  _buildStatementList(context, transactions),
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

  Widget _buildDatePickers() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            spacing: 5,
            children: [
              Expanded(
                child: AppDatePicker(
                  selectedDate: startDate,
                  onDateChanged: (d) => _handleDateChange(d!, isFromDate: true),
                  label: 'From Date',
                  errorText: _errorText,
                ),
              ),

              Expanded(
                child: AppDatePicker(
                  selectedDate: endDate,
                  onDateChanged:
                      (d) => _handleDateChange(d!, isFromDate: false),
                  label: 'To Date',
                  errorText: _errorText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppSecondaryButton(
            label: "",
            iconBefore: Icon(Icons.filter_alt),
            onPressed: () {
              if (_errorText == null) {
                context.read<AccountStatementBloc>().add(
                  FetchAccountStatementEvent(
                    accountNumber: widget.accountNumber,
                    fromDate:
                        "${startDate.year}/${startDate.month}/${startDate.day}",
                    toDate: "${endDate.year}/${endDate.month}/${endDate.day}",
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
    );
  }

  Widget _buildChart(List<AccountTransactionEntity> transactions) {
    return SfCartesianChart(
      title: ChartTitle(
        text: Locales.string(context, 'transaction_graph'),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
          name: Locales.string(context, 'cash_in'),
          dataSource: transactions,
          xValueMapper: (txn, _) => MyDateUtils.getShortMonthName(txn.date),
          yValueMapper: (txn, _) => txn.credit,
          color: Colors.green,
          markerSettings: const MarkerSettings(isVisible: true),
        ),
        LineSeries<AccountTransactionEntity, String>(
          name: Locales.string(context, 'cash_out'),
          dataSource: transactions,
          xValueMapper: (txn, _) => MyDateUtils.getShortMonthName(txn.date),
          yValueMapper: (txn, _) => txn.debit,
          color: Colors.red,
          markerSettings: const MarkerSettings(isVisible: true),
        ),
      ],
    );
  }

  Widget _buildStatementList(
    BuildContext context,
    List<AccountTransactionEntity> transactions,
  ) {
    return Container(
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
          AccountStatmentSection(accountStatment: transactions),
        ],
      ),
    );
  }
}
