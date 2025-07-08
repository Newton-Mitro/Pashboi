import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/extensions/string_casing_extension.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/utils/my_date_utils.dart';
import 'package:pashboi/core/utils/taka_formatter.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/entities/loan_transaction_entity.dart';
import 'package:pashboi/features/authenticated/my_loans/presentation/pages/loan_details_page/bloc/loan_details_bloc.dart';
import 'package:pashboi/features/authenticated/my_loans/presentation/pages/loan_statement_section/bloc/loan_statement_bloc.dart';
import 'package:pashboi/features/authenticated/my_loans/presentation/pages/loan_statement_section/loan_statment_section.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LoanDetailsPage extends StatefulWidget {
  final String loanNumber;
  const LoanDetailsPage({super.key, required this.loanNumber});

  @override
  State<LoanDetailsPage> createState() => _LoanDetailsPageState();
}

class _LoanDetailsPageState extends State<LoanDetailsPage> {
  Widget buildInfoRow(
    BuildContext context,
    String title,
    String value, {
    IconData icon = Icons.info_outline,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Icon(icon, size: 20, color: colorScheme.onPrimary),
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

  Widget _buildCircleStat(
    BuildContext context,
    String title,
    String value,
    Color backgroundColor,
    Color borderColor,
  ) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 3),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: context.theme.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: context.theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  sl<LoanDetsilsBloc>()
                    ..add(FetchLoanDetsilsEvent(loanNumber: widget.loanNumber)),
        ),
        BlocProvider(
          create:
              (context) =>
                  sl<LoanStatementBloc>()..add(
                    FetchLoanStatementEvent(loanNumber: widget.loanNumber),
                  ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Loan Details')),
        body: PageContainer(
          child: BlocBuilder<LoanDetsilsBloc, LoanDetailsState>(
            builder: (context, state) {
              if (state is LoanDetsilsLoading || state is LoanDetailsInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is LoanDetailsError) {
                return Center(child: Text(state.error));
              }

              if (state is LoanDetailsSuccess) {
                final account = state.loan;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 35),
                      Icon(
                        FontAwesomeIcons.sackDollar,
                        size: 60,
                        color: context.theme.colorScheme.onSurface,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        account.loaneeName.toTitleCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: context.theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        account.typeName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: context.theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        account.number,
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
                              account.status.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                color: context.theme.colorScheme.onSecondary,
                              ),
                            ),
                            backgroundColor:
                                context.theme.colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          Chip(
                            label: Text(
                              account.defaulter ? "Defaulter" : "Regular",
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    account.defaulter
                                        ? context.theme.colorScheme.onError
                                        : context.theme.colorScheme.onPrimary,
                              ),
                            ),
                            backgroundColor:
                                account.defaulter
                                    ? context.theme.colorScheme.error
                                    : context.theme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildCircleStat(
                            context,
                            "Issued",
                            TakaFormatter.format(account.issuedAmount),
                            context.theme.colorScheme.primary,
                            context.theme.colorScheme.onPrimary,
                          ),
                          _buildCircleStat(
                            context,
                            "Balance",
                            TakaFormatter.format(account.loanBalance),
                            context.theme.colorScheme.secondary,
                            context.theme.colorScheme.onSecondary,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Column(
                        children: [
                          buildInfoRow(
                            context,
                            "Last Deposit Date",
                            MyDateUtils.formatDate(account.lastPaidDate),
                            icon: FontAwesomeIcons.calendarCheck,
                          ),
                          buildInfoRow(
                            context,
                            "Refund Amount",
                            TakaFormatter.format(account.refundAmount),
                          ),
                          buildInfoRow(
                            context,
                            "Last Deposit Date",
                            MyDateUtils.formatDate(account.loanEndDate),
                            icon: FontAwesomeIcons.hourglassEnd,
                          ),
                          buildInfoRow(
                            context,
                            "Interest Rate",
                            "${account.interestRate.toStringAsFixed(2)}%",
                            icon: FontAwesomeIcons.percent,
                          ),
                          buildInfoRow(
                            context,
                            "Interest Days",
                            "${account.interestForDays} Days",
                            icon: FontAwesomeIcons.clock,
                          ),
                          buildInfoRow(
                            context,
                            "Installments",
                            account.numberOfInstallments.toString(),
                            icon: FontAwesomeIcons.listOl,
                          ),
                          buildInfoRow(
                            context,
                            "Defaulter Reason",
                            account.defaulterReason,
                            icon: FontAwesomeIcons.triangleExclamation,
                          ),
                          BlocBuilder<LoanStatementBloc, LoanStatementState>(
                            builder: (context, loanStatement) {
                              if (loanStatement is LoanStatementLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (loanStatement is LoanStatementSuccess) {
                                final accountStatement =
                                    loanStatement.transactions;

                                return Column(
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
                                        overflowMode:
                                            LegendItemOverflowMode.wrap,
                                      ),
                                      tooltipBehavior: TooltipBehavior(
                                        enable: true,
                                      ),
                                      primaryXAxis: CategoryAxis(),
                                      primaryYAxis: NumericAxis(),
                                      series: <CartesianSeries>[
                                        LineSeries<
                                          LoanTransactionEntity,
                                          String
                                        >(
                                          name: 'Loan Issued',
                                          dataSource: accountStatement,
                                          xValueMapper:
                                              (txn, _) =>
                                                  MyDateUtils.getShortMonthName(
                                                    txn.transactionDate,
                                                  ),
                                          yValueMapper:
                                              (txn, _) => txn.creditAmount,
                                          color: Colors.green,
                                          markerSettings: const MarkerSettings(
                                            isVisible: true,
                                          ),
                                        ),
                                        LineSeries<
                                          LoanTransactionEntity,
                                          String
                                        >(
                                          name: 'Loan Repaid',
                                          dataSource: accountStatement,
                                          xValueMapper:
                                              (txn, _) =>
                                                  MyDateUtils.getShortMonthName(
                                                    txn.transactionDate,
                                                  ),
                                          yValueMapper:
                                              (txn, _) => txn.debitAmount,
                                          color: Colors.red,
                                          markerSettings: const MarkerSettings(
                                            isVisible: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                        color:
                                            context.theme.colorScheme.surface,
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 16),
                                          Text(
                                            "Half Yearly Statement",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  context
                                                      .theme
                                                      .colorScheme
                                                      .onSurface,
                                            ),
                                          ),
                                          LoanStatmentSection(
                                            loanStatement: accountStatement,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 50),
                                  ],
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
                        ],
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
