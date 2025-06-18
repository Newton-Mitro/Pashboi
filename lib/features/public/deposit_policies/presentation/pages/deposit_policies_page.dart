import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
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
      'name': 'Credit Account',
      'description': 'For self-reliant members of the union.',
      'icon': '💳',
    },
    {
      'name': 'STD Account',
      'description': 'Provides interest twice a year.',
      'icon': '📅',
    },
    {
      'name': 'Bee-Savers',
      'description': 'For children from 1 day to 12 years old.',
      'icon': '🐝',
    },
    {
      'name': 'Smart Savers',
      'description': 'Promotes savings among teenagers.',
      'icon': '💡',
    },
    {
      'name': 'Education Savings',
      'description': 'Helps members meet educational expenses.',
      'icon': '🎓',
    },
    {
      'name': 'LTSD Account',
      'description': 'Earn high interest for a fixed rate.',
      'icon': '📈',
    },
    {
      'name': 'Monthly Savings',
      'description': 'Prepares for future requirements.',
      'icon': '📆',
    },
    {
      'name': 'Festival Savings',
      'description': 'Save for festive season expenses.',
      'icon': '🎉',
    },
    {
      'name': 'Troimashik Savings',
      'description': 'Quarterly interest with a minimum deposit of 1 Lac.',
      'icon': '💸',
    },
    {
      'name': 'Aged Savings',
      'description': 'Ensures financial security after retirement.',
      'icon': '👴',
    },
    {
      'name': 'Double Deposit',
      'description': 'Double benefits for the depositors.',
      'icon': '🔁',
    },
    {
      'name': 'Millionaire Deposit',
      'description': 'Become a millionaire within a set period.',
      'icon': '💎',
    },
    {
      'name': 'Housing Deposit',
      'description': 'Helps achieve the dream of owning a house.',
      'icon': '🏠',
    },
    {
      'name': 'Marriage Deposit',
      'description': 'Perfect for dealing with marriage costs.',
      'icon': '💍',
    },
    {
      'name': 'Kotipoti Deposit',
      'description':
          'Premium deposit scheme for members to become a “KotiPoti”.',
      'icon': '💰',
    },
    {
      'name': 'Hospital Bond',
      'description': 'Part of Divine Mercy General Hospital Bond.',
      'icon': '🏥',
    },
    {
      'name': 'D.C. H.C.S',
      'description': 'Dhaka Credit Health Care Scheme for everyone.',
      'icon': '❤️',
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
      child: ListView.builder(
        itemCount: depositProducts.length,
        itemBuilder: (context, index) {
          final product = depositProducts[index];
          return Card(
            elevation: 1,
            shadowColor: const Color.fromARGB(179, 0, 0, 0),
            surfaceTintColor: context.theme.colorScheme.primary,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                    builder: (context) => const DepositPolicyDetailsPage(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
