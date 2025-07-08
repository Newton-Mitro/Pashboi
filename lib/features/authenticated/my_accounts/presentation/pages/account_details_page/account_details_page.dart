import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/extensions/string_casing_extension.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/utils/my_date_utils.dart';
import 'package:pashboi/core/utils/taka_formatter.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/account_transaction_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_details_page/bloc/account_details_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_statement_section/account_statment_section.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_statement_section/bloc/account_statement_bloc.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AccountDetailsPage extends StatefulWidget {
  final String accountNumber;
  const AccountDetailsPage({super.key, required this.accountNumber});

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
      padding: const EdgeInsets.symmetric(vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.primary,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
      ),
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  sl<AccountDetailsBloc>()..add(
                    FetchAccountDetailsEvent(
                      accountNumber: widget.accountNumber,
                    ),
                  ),
        ),
        BlocProvider(
          create:
              (context) =>
                  sl<AccountStatementBloc>()..add(
                    FetchAccountStatementEvent(
                      accountNumber: widget.accountNumber,
                    ),
                  ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Account Details')),
        body: PageContainer(
          child: BlocBuilder<AccountDetailsBloc, AccountDetailsState>(
            builder: (context, state) {
              if (state is AccountDetailsLoading ||
                  state is AccountDetailsInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is AccountDetailsError) {
                return Center(child: Text(state.error));
              }

              if (state is AccountDetailsSuccess) {
                final account = state.account;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 35),
                      Icon(
                        FontAwesomeIcons.piggyBank,
                        size: 60,
                        color: context.theme.colorScheme.onSurface,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        account.name.toTitleCase(),
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
                              account.defaultAccount ? "Defaulter" : "Regular",
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    account.defaultAccount
                                        ? context.theme.colorScheme.onError
                                        : context.theme.colorScheme.onPrimary,
                              ),
                            ),
                            backgroundColor:
                                account.defaultAccount
                                    ? context.theme.colorScheme.error
                                    : context.theme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: BorderSide(
                              color:
                                  account.defaultAccount
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
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildCircleStat(
                            context,
                            "Balance",
                            TakaFormatter.format(account.balance),
                            context.theme.colorScheme.secondary,
                            context.theme.colorScheme.onSecondary,
                          ),
                          if (account.typeCode == "16")
                            _buildCircleStat(
                              context,
                              "Withdrawable",
                              TakaFormatter.format(account.withdrawableBalance),
                              context.theme.colorScheme.primary,
                              context.theme.colorScheme.onPrimary,
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
                            "Maturity Date",
                            MyDateUtils.formatDate(account.maturityDate),
                            icon: FontAwesomeIcons.hourglassEnd,
                          ),
                          buildInfoRow(
                            context,
                            "Nominee",
                            account.nominees,
                            icon: FontAwesomeIcons.userShield,
                          ),
                          BlocBuilder<
                            AccountStatementBloc,
                            AccountStatementState
                          >(
                            builder: (context, accountStatementState) {
                              if (accountStatementState
                                  is AccountStatementLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (accountStatementState
                                  is AccountStatementSuccess) {
                                final accountStatement =
                                    accountStatementState.transactions;
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
                                          AccountTransactionEntity,
                                          String
                                        >(
                                          name: 'Cash IN',
                                          dataSource: accountStatement,
                                          xValueMapper:
                                              (txn, _) =>
                                                  MyDateUtils.getShortMonthName(
                                                    txn.date,
                                                  ),
                                          yValueMapper: (txn, _) => txn.credit,
                                          color: Colors.green,
                                          markerSettings: const MarkerSettings(
                                            isVisible: true,
                                          ),
                                        ),
                                        LineSeries<
                                          AccountTransactionEntity,
                                          String
                                        >(
                                          name: 'Cash OUT',
                                          dataSource: accountStatement,
                                          xValueMapper:
                                              (txn, _) =>
                                                  MyDateUtils.getShortMonthName(
                                                    txn.date,
                                                  ),
                                          yValueMapper: (txn, _) => txn.debit,
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
                                      margin: EdgeInsets.all(10),
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
                                          AccountStatmentSection(
                                            accountStatment: accountStatement,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 50),
                                  ],
                                );
                              }
                              if (accountStatementState
                                  is AccountStatementError) {
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
}
