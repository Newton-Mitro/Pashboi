import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/menu_tile.dart';

class AccountsMenusView extends StatefulWidget {
  const AccountsMenusView({super.key});

  @override
  State<AccountsMenusView> createState() => _AccountsMenusViewState();
}

class _AccountsMenusViewState extends State<AccountsMenusView> {
  final List<Map<String, dynamic>> infoMenus = [
    {
      "icon": Icons.account_balance,
      "menuName": "Accounts",
      "menuDescription":
          "View and manage your  accounts, balances, and transactions from here",
    },
    {
      "icon": Icons.credit_card,
      "menuName": "Open an Account",
      "menuDescription":
          "Process to open a new account quickly and easily from here",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        itemCount: infoMenus.length,
        padding: const EdgeInsets.all(12),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final menu = infoMenus[index];
          return MenuTile(
            icon: Icon(
              menu['icon'],
              size: 35,
              color: context.theme.colorScheme.onPrimary,
            ),
            menuName: menu['menuName'],
            menuDescription: menu['menuDescription'],
            onTap: () {
              debugPrint("Tapped on ${menu['menuName']}");
            },
          );
        },
      ),
    );
  }
}
