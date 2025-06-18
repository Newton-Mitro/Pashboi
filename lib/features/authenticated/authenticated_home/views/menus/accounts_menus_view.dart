import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountsMenusView extends StatefulWidget {
  const AccountsMenusView({super.key});

  @override
  State<AccountsMenusView> createState() => _AccountsMenusViewState();
}

class _AccountsMenusViewState extends State<AccountsMenusView> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> infoMenus = [
      {
        "icon": Icons.account_balance,
        "menuName": Locales.string(context, "accounts_menu_accounts_title"),
        "menuDescription": Locales.string(
          context,
          "accounts_menu_accounts_description",
        ),
        "route": AuthRoutesName.myAccountsPage,
      },
      {
        "icon": Icons.credit_card,
        "menuName": Locales.string(
          context,
          "accounts_menu_open_an_account_title",
        ),
        "menuDescription": Locales.string(
          context,
          "accounts_menu_open_an_account_description",
        ),
        "route": AuthRoutesName.createNewAccountPage,
      },
    ];
    return SafeArea(
      child: ListView.separated(
        itemCount: infoMenus.length,
        padding: const EdgeInsets.all(12),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final menu = infoMenus[index];
          return MenuCard(
            iconData: menu['icon'],
            menuName: menu['menuName'],
            menuDescription: menu['menuDescription'],
            onTap: () {
              Navigator.pushNamed(context, menu['route']);
            },
          );
        },
      ),
    );
  }
}
