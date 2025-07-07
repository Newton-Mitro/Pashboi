import 'package:flutter/material.dart';
import 'package:pashboi/routes/auth_routes_name.dart';

class OpenableAccountsPage extends StatefulWidget {
  const OpenableAccountsPage({super.key});

  @override
  State<OpenableAccountsPage> createState() => _OpenableAccountsPageState();
}

class _OpenableAccountsPageState extends State<OpenableAccountsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Openable Accounts')),
      body: const Center(
        child: Text(
          'No accounts available to open.',
          style: TextStyle(fontSize: 16),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AuthRoutesName.createNewAccountPage,
            arguments: {'productCode': '18'},
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
