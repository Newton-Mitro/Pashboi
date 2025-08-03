import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/menu_card.dart';

class AccountsMenusView extends StatefulWidget {
  const AccountsMenusView({super.key});

  @override
  State<AccountsMenusView> createState() => _AccountsMenusViewState();
}

class _AccountsMenusViewState extends State<AccountsMenusView> {
  List<Map<String, dynamic>> getInfoMenus(BuildContext context) {
    final color = Theme.of(context).colorScheme.onPrimary;

    return [
      {
        "icon": Icon(FontAwesomeIcons.piggyBank, color: color, size: 30),
        "menuName": Locales.string(context, "accounts_menu_accounts_title"),
        "menuDescription": Locales.string(
          context,
          "accounts_menu_accounts_description",
        ),
        "route": AuthRoutesName.myAccountsPage,
      },
      {
        "icon": Icon(Icons.account_balance, color: color, size: 30),
        "menuName": Locales.string(
          context,
          "accounts_menu_open_an_account_title",
        ),
        "menuDescription": Locales.string(
          context,
          "accounts_menu_open_an_account_description",
        ),
        "route": AuthRoutesName.openableAccountsPage,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final infoMenus = getInfoMenus(context);

    return SafeArea(
      child: ListView.separated(
        itemCount: infoMenus.length,
        padding: const EdgeInsets.all(12),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final menu = infoMenus[index];
          return MenuCard(
            icon: menu['icon'],
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
