import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/menu_tile.dart';

class PersonnelMenusView extends StatefulWidget {
  const PersonnelMenusView({super.key});

  @override
  State<PersonnelMenusView> createState() => _PersonnelMenusViewState();
}

class _PersonnelMenusViewState extends State<PersonnelMenusView> {
  final List<Map<String, dynamic>> infoMenus = [
    {
      "icon": Icons.account_balance,
      "menuName": "Personnel",
      "menuDescription": "Place for all your dependent accounts.",
    },
    {
      "icon": Icons.credit_card,
      "menuName": "Cards",
      "menuDescription": "Manage your debit or credit cards easily.",
    },
    {
      "icon": Icons.security,
      "menuName": "Security",
      "menuDescription": "Adjust your security and privacy preferences.",
    },
    {
      "icon": Icons.settings,
      "menuName": "Settings",
      "menuDescription": "Customize your application settings.",
    },
    {
      "icon": Icons.support_agent,
      "menuName": "Support",
      "menuDescription": "Get help and support quickly.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.separated(
          itemCount: infoMenus.length,
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
      ),
    );
  }
}
