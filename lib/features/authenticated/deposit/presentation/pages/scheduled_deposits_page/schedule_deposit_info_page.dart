import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/utils/my_date_utils.dart';
import 'package:pashboi/core/utils/taka_formatter.dart';
import 'package:pashboi/features/authenticated/deposit/domain/entities/voucher_entity.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class ScheduleDepositInfoPage extends StatelessWidget {
  final DepositRequestEntity? depositRequest;

  const ScheduleDepositInfoPage({super.key, required this.depositRequest});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    final totalAmount =
        depositRequest?.transactions.fold<double>(
          0,
          (sum, ledger) => sum + ledger.amount,
        ) ??
        0;

    return Scaffold(
      appBar: AppBar(title: const Text("Schedule Deposit Info")),
      body: PageContainer(
        child: Stack(
          children: [
            // Scrollable content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Schedule Info
                  if (depositRequest != null) ...[
                    const SectionTitle("Schedule Information"),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 16,
                        left: 16,
                        right: 16,
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        border: Border.all(
                          color: colorScheme.primary,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "REQUEST ID: ${depositRequest!.id}",
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            "Schedule Date: ${MyDateUtils.formatDate(depositRequest!.depositDate)}",
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            "Status: ${depositRequest!.status}",
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SectionTitle("Accounts To Deposit"),
                  Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (depositRequest != null)
                              for (final ledger in depositRequest!.transactions)
                                Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: colorScheme.surface,
                                    border: Border.all(
                                      color: colorScheme.primary,
                                      width: 1.2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ledger.perticulars,
                                              style: TextStyle(
                                                color: colorScheme.onSurface,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                              ),
                                            ),
                                            Text(
                                              ledger.accountNumber,
                                              style: TextStyle(
                                                color: colorScheme.onSurface,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        TakaFormatter.format(ledger.amount),
                                        style: TextStyle(
                                          color: colorScheme.onSurface,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                            // Padding at bottom so content isn't hidden
                            const SizedBox(height: 70),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Fixed Bottom Total
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border(
                    top: BorderSide(color: colorScheme.primary, width: 1.2),
                  ),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Deposit Amount:",
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      TakaFormatter.format(totalAmount),
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
