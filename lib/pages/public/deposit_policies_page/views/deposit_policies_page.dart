import 'package:flutter/material.dart';
import 'package:pashboi/pages/public/deposit_policy_details_page/views/deposit_policy_details_page.dart';

class DepositPoliciesPae extends StatefulWidget {
  const DepositPoliciesPae({super.key});

  @override
  State<DepositPoliciesPae> createState() => _DepositPoliciesPaeState();
}

class _DepositPoliciesPaeState extends State<DepositPoliciesPae> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Deposit Policies')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DepositPolicyDetailsPage(),
              ),
            );
          },
          child: Text('View Deposit Policy Details'),
        ),
      ),
    );
  }
}
