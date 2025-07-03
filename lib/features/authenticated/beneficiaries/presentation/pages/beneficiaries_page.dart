import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/authenticated/beneficiaries/presentation/pages/bloc/beneficiary_bloc.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/widgets/app_icon_card.dart';

class BeneficiariesPage extends StatelessWidget {
  const BeneficiariesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return BlocProvider(
      create: (context) => sl<BeneficiaryBloc>()..add(FetchBeneficiaries()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Beneficiaries')),
        body: PageContainer(
          child: SafeArea(
            child: BlocBuilder<BeneficiaryBloc, BeneficiaryState>(
              builder: (context, state) {
                if (state is BeneficiaryLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is BeneficiaryLoaded) {
                  final beneficiaries = state.beneficiaries;

                  if (beneficiaries.isEmpty) {
                    return Center(
                      child: Text(
                        'You don’t have any beneficiaries added',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    itemCount: beneficiaries.length,
                    itemBuilder: (context, index) {
                      final info = beneficiaries[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Dismissible(
                          key: ValueKey(info.accountNumber),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.red,
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (_) {
                            context.read<BeneficiaryBloc>().add(
                              DeleteBeneficiary(info.accountNumber),
                            );
                          },
                          child: AppIconCard(
                            leftIcon: FontAwesomeIcons.userShield,
                            boarderColor: theme.colorScheme.primary,
                            cardBody: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  info.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  info.accountNumber,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    "Beneficiary",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: theme.colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              // Optional full card tap handler
                            },
                          ),
                        ),
                      );
                    },
                  );
                }

                if (state is BeneficiaryError) {
                  return Center(child: Text(state.error));
                }

                // fallback (e.g. initial state)
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 25.0, top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Click to add a new beneficiary!',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              AppPrimaryButton(
                iconBefore: const Icon(Icons.person_add),
                label: "Add Beneficiary",
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AuthRoutesName.addBeneficiaryPage,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
