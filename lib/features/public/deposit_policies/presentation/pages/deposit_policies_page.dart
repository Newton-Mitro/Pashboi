import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/public/deposit_policies/domain/enities/deposit_policy_entity.dart';
import 'package:pashboi/features/public/deposit_policies/presentation/pages/bloc/deposit_policy_bloc.dart';
import 'package:pashboi/features/public/deposit_policies/presentation/pages/deposit_policy_details_page.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DepositPoliciesPage extends StatelessWidget {
  const DepositPoliciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => sl<DepositPolicyBloc>()..add(FetchDepositPolicyEvent()),
      child: PageContainer(
        child: BlocBuilder<DepositPolicyBloc, DepositPolicyState>(
          builder: (context, state) {
            if (state is DepositProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DepositPolicyError) {
              return Center(child: Text('Error: ${state.error}'));
            } else if (state is DepositPolicySuccess) {
              final List<DepositPolicyEntity> products = state.depositPolicies;

              if (products.isEmpty) {
                return const Center(child: Text('No deposit products found.'));
              }

              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    elevation: 1,
                    shadowColor: const Color.fromARGB(179, 0, 0, 0),
                    color: context.theme.colorScheme.surface,
                    surfaceTintColor: context.theme.colorScheme.error,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.piggyBank,
                        size: 24,
                        color: context.theme.colorScheme.onSurface,
                      ),
                      title: Text(
                        product.title,
                        style: TextStyle(
                          color: context.theme.colorScheme.onSurface,
                        ),
                      ),
                      subtitle: Text(
                        product.shortDescription,
                        style: TextStyle(
                          color: context.theme.colorScheme.onSurface,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => DepositPolicyDetailsPage(
                                  depositPolicy: product,
                                ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }

            return const SizedBox.shrink(); // default fallback
          },
        ),
      ),
    );
  }
}
