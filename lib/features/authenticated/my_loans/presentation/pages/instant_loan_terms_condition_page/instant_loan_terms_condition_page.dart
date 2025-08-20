import 'package:flutter/material.dart';

class InstantLoanTermsAndConditionPage extends StatefulWidget {
  const InstantLoanTermsAndConditionPage({super.key});

  @override
  State<InstantLoanTermsAndConditionPage> createState() =>
      _InstantLoanTermsAndConditionPageState();
}

class _InstantLoanTermsAndConditionPageState
    extends State<InstantLoanTermsAndConditionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Terms and Conditions')),
      body: Center(child: Text('Terms and Conditions for Instant Loan')),
    );
  }
}
