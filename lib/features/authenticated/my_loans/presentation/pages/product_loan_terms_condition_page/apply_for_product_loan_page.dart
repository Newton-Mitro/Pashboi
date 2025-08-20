import 'package:flutter/material.dart';

class ApplyForProductLoanPage extends StatefulWidget {
  const ApplyForProductLoanPage({super.key});

  @override
  State<ApplyForProductLoanPage> createState() =>
      _ApplyForProductLoanPageState();
}

class _ApplyForProductLoanPageState extends State<ApplyForProductLoanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Terms and Conditions')),
      body: Center(child: Text('Terms and Conditions for Product Loan')),
    );
  }
}
