import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/utils/my_date_utils.dart';
import 'package:pashboi/features/authenticated/deposit/presentation/pages/scheduled_deposits_page/bloc/scheduled_deposits_bloc.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/widgets/app_icon_card.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class ScheduledDepositsPage extends StatefulWidget {
  const ScheduledDepositsPage({super.key});

  @override
  State<ScheduledDepositsPage> createState() => _ScheduledDepositsPageState();
}

class _ScheduledDepositsPageState extends State<ScheduledDepositsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ScheduledDepositsBloc>().add(FetchScheduledDeposits());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scheduled Deposits Page")),
      body: PageContainer(
        child: SafeArea(
          child: BlocBuilder<ScheduledDepositsBloc, ScheduledDepositsState>(
            builder: (context, state) {
              if (state is ScheduledDepositsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ScheduledDepositsFailure) {
                return Center(
                  child: Text(
                    state.error,
                    style: TextStyle(
                      color: context.theme.colorScheme.error,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }

              if (state is ScheduledDepositsLoaded) {
                final familyList = state.depositRequests;

                if (familyList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FontAwesomeIcons.boxOpen,
                          size: 60,
                          color: context.theme.colorScheme.onSurface
                              .withOpacity(0.4),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'You don’t have any family or relative added yet.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: context.theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  itemCount: familyList.length,
                  itemBuilder: (context, index) {
                    final info = familyList[index];
                    final requestStatus = info.status;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: AppIconCard(
                        leftIcon: FontAwesomeIcons.calendarDays,
                        cardBody: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "REQUEST ID: ${info.id}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: context.theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Scheduled Date: ${MyDateUtils.formatDate(info.depositDate)}",
                              style: TextStyle(
                                fontSize: 12,
                                color: context.theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 0,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    requestStatus == "Approved"
                                        ? Colors.green
                                        : Colors.orange,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                requestStatus,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.normal,
                                  color:
                                      requestStatus == "Approved"
                                          ? context.theme.colorScheme.onTertiary
                                          : context
                                              .theme
                                              .colorScheme
                                              .onSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        boarderColor: context.theme.colorScheme.primary,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AuthRoutesName.depositRequestInfoPage,
                            arguments: {'depositRequest': info},
                          );
                        },
                      ),
                    );
                  },
                );
              }

              // Default fallback (initial state or add success)
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
