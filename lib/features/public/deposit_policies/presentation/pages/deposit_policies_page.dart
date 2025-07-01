import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/public/deposit_policies/presentation/bloc/deposit_product_bloc.dart';
import 'package:pashboi/features/public/deposit_policies/presentation/pages/deposit_policy_details_page.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class DepositPoliciesPage extends StatefulWidget {
  const DepositPoliciesPage({super.key});

  @override
  State<DepositPoliciesPage> createState() => _DepositPoliciesPageState();
}

class _DepositPoliciesPageState extends State<DepositPoliciesPage> {
  final List<Map<String, String>> depositProducts = [
    {
      'name': 'Savings Account',
      'description': 'Mandatory for all other products in Dhaka Credit.',
      'icon': '💰',
    },
    {
      'name': 'Pension Benefit',
      'description': 'Pension Benefit Scheme for future retirement.',
      'icon': '👵',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: BlocProvider(
        create: (context) => sl<DepositProductBloc>(),
        child: BlocBuilder<DepositProductBloc, DepositProductState>(
          builder: (context, state) {
            if (state is DepositProductInitial) {
              context.read<DepositProductBloc>().add(GetDepositProduct());
              return const Center(child: CircularProgressIndicator());
            }

            if (state is DepositProductSuccess) {
              return ListView.builder(
                itemCount: depositProducts.length,
                itemBuilder: (context, index) {
                  final product = depositProducts[index];

                  return Card(
                    elevation: 1,
                    shadowColor: const Color.fromARGB(179, 0, 0, 0),
                    surfaceTintColor: context.theme.colorScheme.primary,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: Text(
                        product['icon'] ?? '',
                        style: const TextStyle(fontSize: 28),
                      ),
                      title: Text(product['name'] ?? ''),
                      subtitle: Text(product['description'] ?? ''),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => const DepositPolicyDetailsPage(),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }

            return const Center(child: Text("Something went wrong."));
          },
        ),
      ),
    );
  }
}
