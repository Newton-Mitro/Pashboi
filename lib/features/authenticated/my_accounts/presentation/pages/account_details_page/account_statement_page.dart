import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/shared/widgets/app_date_picker.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:pashboi/core/utils/my_date_utils.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/account_transaction_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_statement_section/account_statment_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_statement_section/bloc/account_statement_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class AccountStatementPage extends StatefulWidget {
  final String accountNumber;
  const AccountStatementPage({super.key, required this.accountNumber});

  @override
  State<AccountStatementPage> createState() => _AccountStatementPageState();
}

class _AccountStatementPageState extends State<AccountStatementPage> {
  DateTime? _fromDate;
  DateTime? _toDate;
  String? _errorText;

  void _handleDateChange(DateTime? date, {required bool isFromDate}) {
    setState(() {
      if (isFromDate) {
        _fromDate = date;
      } else {
        _toDate = date;
      }
      if (_fromDate != null &&
          _toDate != null &&
          _toDate!.isBefore(_fromDate!)) {
        _errorText = 'To Date must be after From Date';
      } else {
        _errorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account Statement")),
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
          AppDatePicker(
            selectedDate: _fromDate,
            onDateChanged: (date) => _handleDateChange(date, isFromDate: true),
            label: 'From Date',
            errorText: _errorText,
          ),
          const SizedBox(height: 12),
          AppDatePicker(
            selectedDate: _toDate,
            onDateChanged: (date) => _handleDateChange(date, isFromDate: false),
            label: 'To Date',
            errorText: _errorText,
          ),
          const SizedBox(height: 8),

          AppPrimaryButton(
            label: "Submit",
            iconBefore: Icon(Icons.filter_alt),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildChart(List<AccountTransactionEntity> transactions) {
    return SfCartesianChart(
      title: ChartTitle(
        text: 'Transactions Graph',
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
          name: 'Cash IN',
          dataSource: transactions,
          xValueMapper: (txn, _) => MyDateUtils.getShortMonthName(txn.date),
          yValueMapper: (txn, _) => txn.credit,
          color: Colors.green,
          markerSettings: const MarkerSettings(isVisible: true),
        ),
        LineSeries<AccountTransactionEntity, String>(
          name: 'Cash OUT',
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
            "Statement",
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
