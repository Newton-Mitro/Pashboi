import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/extensions/string_casing_extension.dart';
import 'package:pashboi/core/utils/taka_formatter.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_statment_section.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:accordion/accordion.dart';

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
                    color: colorScheme.onSurface.withValues(alpha: 0.8),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 35),
                  Icon(
                    FontAwesomeIcons.piggyBank,
                    size: 60,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Account Holder",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: context.theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "AccountTypeName",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: context.theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "AccountNo",
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
                          "STATUS",
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
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      Chip(
                        label: Text(
                          (false) ? "Defaulter" : "Regular",
                          style: TextStyle(
                            fontSize: 12,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                        backgroundColor:
                            (false)
                                ? context.theme.colorScheme.error
                                : context.theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(
                          color:
                              (false)
                                  ? context.theme.colorScheme.error
                                  : context.theme.colorScheme.primary,
                          width: 1,
                        ),
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.theme.colorScheme.secondary,
                      border: Border.all(
                        color: context.theme.colorScheme.onSecondary,
                        width: 3,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Balance",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          TakaFormatter.format(0),
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
                        width: 3,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Withdrawable",
                          textAlign: TextAlign.center,

                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          TakaFormatter.format(0),
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
              Column(
                children: [
                  buildInfoRow(
                    context,
                    "Last Deposit Date",
                    true ? "Date" : 'No deposit',
                    icon: FontAwesomeIcons.calendarCheck,
                  ),
                  buildInfoRow(
                    context,
                    "Maturity Date",
                    "Date",
                    icon: FontAwesomeIcons.hourglassEnd,
                  ),
                  buildInfoRow(
                    context,
                    "Nominee",
                    "AccountNominee",
                    icon: FontAwesomeIcons.userShield,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // SfCartesianChart(
              //   title: ChartTitle(
              //     text: 'Half Yearly Transactions',
              //     textStyle: const TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 16,
              //     ),
              //   ),
              //   legend: Legend(
              //     isVisible: true,
              //     position: LegendPosition.top,
              //     overflowMode: LegendItemOverflowMode.wrap,
              //   ),
              //   tooltipBehavior: TooltipBehavior(enable: true),
              //   primaryXAxis: CategoryAxis(),
              //   primaryYAxis: NumericAxis(),
              //   series: <CartesianSeries>[
              //     LineSeries<TransactionAmount, String>(
              //       name: 'Cash IN',
              //       dataSource: depositTransactionData,
              //       xValueMapper: (txn, _) => txn.month,
              //       yValueMapper: (txn, _) => txn.amount,
              //       color: Colors.green,
              //       markerSettings: const MarkerSettings(isVisible: true),
              //     ),
              //     LineSeries<TransactionAmount, String>(
              //       name: 'Cash OUT',
              //       dataSource: withdrawTransactionData,
              //       xValueMapper: (txn, _) => txn.month,
              //       yValueMapper: (txn, _) => txn.amount,
              //       color: Colors.red,
              //       markerSettings: const MarkerSettings(isVisible: true),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 20),
              // Accordion(
              //   headerBackgroundColorOpened: context.theme.colorScheme.primary,
              //   headerPadding: const EdgeInsets.symmetric(
              //     vertical: 16,
              //     horizontal: 20,
              //   ),
              //   children: [
              //     AccordionSection(
              //       isOpen: true,
              //       leftIcon: const Icon(FontAwesomeIcons.fileContract),
              //       headerBackgroundColor: context.theme.colorScheme.primary,
              //       contentBackgroundColor: context.theme.colorScheme.surface,
              //       headerBackgroundColorOpened:
              //           context.theme.colorScheme.primary,
              //       contentBorderColor: context.theme.colorScheme.primary,
              //       contentHorizontalPadding: 0,
              //       contentVerticalPadding: 0,
              //       header: Text(
              //         'Account Statement',
              //         textAlign: TextAlign.left,
              //       ),
              //       content: Column(
              //         children: [
              //           AccountStatmentSection(accountStatment: accountData),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
