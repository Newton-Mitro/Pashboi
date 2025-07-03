import 'package:flutter/material.dart';

class DependentsAccountsPage extends StatefulWidget {
  final int dependentPersonId;
  const DependentsAccountsPage({super.key, required this.dependentPersonId});

  @override
  State<DependentsAccountsPage> createState() => _DependentsAccountsPageState();
}

class _DependentsAccountsPageState extends State<DependentsAccountsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Operating Accounts')),
      body: Center(child: Text('Operating Accounts Page')),
    );
  }
}
