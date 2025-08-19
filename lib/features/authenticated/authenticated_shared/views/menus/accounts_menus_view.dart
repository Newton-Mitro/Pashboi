import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/menu_card.dart';

class AccountsMenusView extends StatefulWidget {
  final UserEntity authUser;

  const AccountsMenusView({super.key, required this.authUser});

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
        "controllerName": "Accounts", // add controllerName
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
        "controllerName": "OpenAccount", // add controllerName
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
    final rolePermissions = widget.authUser.rolePermissions;

    // Extract all allowed controller names
    final allowedControllers =
        rolePermissions
            .map((p) => p.controllerName)
            .whereType<String>()
            .toSet();

    return SafeArea(
      child: ListView.separated(
        itemCount: infoMenus.length,
        padding: const EdgeInsets.all(12),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final menu = infoMenus[index];
          final controllerName = menu['controllerName'] as String?;
          final isEnabled =
              controllerName != null &&
              allowedControllers.contains(controllerName);

          return MenuCard(
            icon: menu['icon'],
            menuName: menu['menuName'],
            menuDescription: menu['menuDescription'],
            onTap:
                isEnabled
                    ? () => Navigator.pushNamed(context, menu['route'])
                    : null, // disable tap if not allowed
            isEnabled: isEnabled, // pass to MenuCard for greying out
          );
        },
      ),
    );
  }
}
