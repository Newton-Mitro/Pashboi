import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/presentation/bloc/fallback_request_bloc.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/widgets/app_icon_card.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class LeaveFallbackAcceptancePage extends StatefulWidget {
  const LeaveFallbackAcceptancePage({super.key});

  @override
  State<LeaveFallbackAcceptancePage> createState() =>
      _LeaveFallbackAcceptancePageState();
}

class _LeaveFallbackAcceptancePageState
    extends State<LeaveFallbackAcceptancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fallback Acceptance")),
      body: PageContainer(child: SingleChildScrollView(child: _buildForm())),
    );
  }

  void initState() {
    super.initState();
    context.read<FallbackRequestBloc>().add(FetchFallbackRequests());
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<FallbackRequestBloc, FallbackRequestState>(
            builder: (context, state) {
              if (state is FallbackRequestLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is FallbackRequestError) {
                return Center(
                  child: Text(
                    state.message ?? 'An error occurred',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (state is FallbackRequestSuccess) {
                final requestList = state.requests;
                if (requestList.isEmpty) {
                  return const Center(
                    child: Text('No fallback requests available.'),
                  );
                }

                return Column(
                  children: List.generate(
                    requestList.length,
                    (index) => AppIconCard(
                      leftIcon: FontAwesomeIcons.mugHot,
                      rightIcon: FontAwesomeIcons.chevronRight,
                      boarderColor: context.theme.colorScheme.primary,
                      cardBody: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            requestList[index].employeeName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "From: ${requestList[index].fromDate.toLocal().toString().split(' ')[0]}",
                          ),
                          Text(
                            "To: ${requestList[index].toDate.toLocal().toString().split(' ')[0]}",
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AuthRoutesName.fallbackAcceptedPage,
                          arguments: {'fallbackRequest': requestList[index]},
                        );
                      },
                    ),
                  ),
                );
              }

              return const SizedBox(height: 10);
            },
          ),
        ],
      ),
    );
  }
}
