import 'package:flutter/material.dart';

class LoanPoliciesPage extends StatefulWidget {
  const LoanPoliciesPage({super.key});

  @override
  State<LoanPoliciesPage> createState() => _LoanPoliciesPageState();
}

class _LoanPoliciesPageState extends State<LoanPoliciesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Loan Policies')),
      body: Center(child: Text('Loan Policies Page')),
    );
  }
}
