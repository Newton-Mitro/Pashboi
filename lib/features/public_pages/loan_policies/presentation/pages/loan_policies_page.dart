import 'package:flutter/material.dart';

class LoanPoliciesPage extends StatefulWidget {
  const LoanPoliciesPage({super.key});

  @override
  State<LoanPoliciesPage> createState() => _LoanPoliciesPageState();
}

class _LoanPoliciesPageState extends State<LoanPoliciesPage> {
  final List<Map<String, String>> loanPolicies = [
    {
      'name': 'General Loan',
      'description': 'Any Member can take loan for various purposes...',
      'icon': '💼',
    },
    {
      'name': 'Business Loan',
      'description':
          'Business Loan provides financial assistance to businesses...',
      'icon': '🏢',
    },
    {
      'name': 'SMB Loan',
      'description':
          'Small & medium size business requires this loan the most...',
      'icon': '💵',
    },
    {
      'name': 'Car Loan',
      'description': 'Own the car of your dream with DC’s Car Loan...',
      'icon': '🚗',
    },
    {
      'name': 'Metro H. Building',
      'description':
          'Build a house with DC’s Metropolitan House Building Loan...',
      'icon': '🏙️',
    },
    {
      'name': 'Flat Purchase',
      'description': 'Owning a dream flat with DC’s Flat Purchase Loan...',
      'icon': '🏠',
    },
    {
      'name': 'House Building Loan',
      'description':
          'Own a high-rise building with DC’s House Building Loan...',
      'icon': '🏢',
    },
    {
      'name': 'Credit Ceiling Loan',
      'description':
          'Business CC Loan is taken to overcome different financial crisis...',
      'icon': '💳',
    },
    {
      'name': 'Industrial Loan',
      'description':
          'Industrial loan supports current and future entrepreneurs...',
      'icon': '🏭',
    },
    {
      'name': 'For Going Abroad',
      'description':
          'Provides Members with financial support for going Abroad...',
      'icon': '✈️',
    },
    {
      'name': 'Solvency For H. Edu',
      'description': 'Students can utilize this loan for studying abroad...',
      'icon': '🎓',
    },
    {
      'name': 'Top Up',
      'description': 'Extra financial boost on Top Up other loans...',
      'icon': '🔼',
    },
    {
      'name': 'Bill Pay Loan',
      'description': 'This loan will help Members overcome bill expenses...',
      'icon': '💳',
    },
    {
      'name': 'Higher Education',
      'description': 'Provides financial support for educational purpose...',
      'icon': '📚',
    },
    {
      'name': 'Higher. Edu Support',
      'description': 'This loan provides the maximum loan of BDT 15 Lac...',
      'icon': '🎓',
    },
    {
      'name': 'Prof. Training',
      'description':
          'This loan is taken to cover professional training cost...',
      'icon': '💼',
    },
    {
      'name': 'Consumer Loan',
      'description': 'This loan helps improve Members standard of living...',
      'icon': '🛒',
    },
    {
      'name': 'D.C Gym Loan',
      'description': 'Lead a healthy lifestyle with Dhaka Credit’s Gym Loan...',
      'icon': '🏋️‍♂️',
    },
    {
      'name': 'Loan Against LTSD',
      'description': 'Any Member can take loan against their LTSD...',
      'icon': '💰',
    },
    {
      'name': 'Open Installment Loan',
      'description': 'Depositors can take Loan against their...',
      'icon': '💳',
    },
    {
      'name': 'Own Share Loan',
      'description': 'The Members can take against their own share...',
      'icon': '💼',
    },
    {
      'name': 'Secured Over Published',
      'description':
          'A Savings depositor can make loan against long-term Savings...',
      'icon': '🔒',
    },
    {
      'name': 'D.C Flat Purchase Loan',
      'description': 'Own a D.C built flat with D.C Flat Purchase Loan...',
      'icon': '🏢',
    },
    {
      'name': 'Emergency Loan',
      'description': 'Emergency Loan is for urgent treatment that may arise...',
      'icon': '🚨',
    },
    {
      'name': 'Instant Loan',
      'description': 'Instant loan to meet urgent financial needs...',
      'icon': '⚡',
    },
    {
      'name': 'Entrepreneur Loan',
      'description': 'This loan is for financial needs of businessmen...',
      'icon': '👨‍💼',
    },
    {
      'name': 'Double Loan on FDR',
      'description': 'Double loan against the Member’s fixed deposit...',
      'icon': '💵',
    },
    {
      'name': 'Various Other Loans',
      'description': 'Rest of the loan facilities are mentioned here...',
      'icon': '📋',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: loanPolicies.length,
        itemBuilder: (context, index) {
          final loanPolicy = loanPolicies[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: Text(
                loanPolicy['icon'] ?? '',
                style: const TextStyle(fontSize: 28),
              ),
              title: Text(loanPolicy['name'] ?? ''),
              subtitle: Text(loanPolicy['description'] ?? ''),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to detailed loan policy page if needed
              },
            ),
          );
        },
      ),
    );
  }
}
