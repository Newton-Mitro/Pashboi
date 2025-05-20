import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/menu_tile.dart';
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
      },
      {
        "icon": FontAwesomeIcons.children,
        "menuName": Locales.string(
          context,
          "accounts_menu_dependents_accounts_title",
        ),
        "menuDescription": Locales.string(
          context,
          "accounts_menu_dependents_accounts_description",
        ),
      },
    ];
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
