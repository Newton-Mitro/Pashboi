import 'package:flutter/material.dart';

class PublicHomeDrawer extends StatelessWidget {
  const PublicHomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("John Doe"),
            accountEmail: Text("john.doe@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo.png"),
            ),
            // decoration: BoxDecoration(color: Colors.blueGrey),
          ),
          ListTile(
            leading: Icon(Icons.stacked_line_chart_outlined),
            title: Text("Info"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.monetization_on_sharp),
            title: Text("Accounts"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.car_rental),
            title: Text("Loans"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.safety_check),
            title: Text("Surety"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.savings),
            title: Text("Deposit"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.atm),
            title: Text("Withdraw"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Text("Transfer"),
            onTap: () {},
          ),
          Spacer(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
