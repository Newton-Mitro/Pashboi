import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/menu_tile.dart';

class BeneficiaryMenusView extends StatefulWidget {
  const BeneficiaryMenusView({super.key});

  @override
  State<BeneficiaryMenusView> createState() => _BeneficiaryMenusViewState();
}

class _BeneficiaryMenusViewState extends State<BeneficiaryMenusView> {
  final List<Map<String, dynamic>> infoMenus = [
    {
      "icon": Icons.account_balance,
      "menuName": "Beneficiary",
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
