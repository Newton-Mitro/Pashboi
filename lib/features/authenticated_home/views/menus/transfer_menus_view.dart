import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/menu_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransferMenusView extends StatefulWidget {
  const TransferMenusView({super.key});

  @override
  State<TransferMenusView> createState() => _TransferMenusViewState();
}

class _TransferMenusViewState extends State<TransferMenusView> {
  final List<Map<String, dynamic>> infoMenus = [
    {
      "icon": FontAwesomeIcons.mobileScreenButton,
      "menuName": "Transfer to bKash",
      "menuDescription":
          "Send money directly from your account to a bKash wallet quickly and securely",
    },
    {
      "icon": FontAwesomeIcons.rightLeft,
      "menuName": "Transfer Within Dhaka Credit",
      "menuDescription":
          "Transfer funds between your own accounts or to other members within Dhaka Credit",
    },
    {
      "icon": FontAwesomeIcons.buildingColumns,
      "menuName": "Bank to Dhaka Credit",
      "menuDescription":
          "Transfer money from an external bank account to your Dhaka Credit account",
    },
    {
      "icon": FontAwesomeIcons.peopleArrows,
      "menuName": "Transfer to Other Cooperatives",
      "menuDescription":
          "Send funds from your Dhaka Credit account to other cooperative institutions",
    },
    {
      "icon": FontAwesomeIcons.clipboardCheck,
      "menuName": "Transfer Request Status",
      "menuDescription":
          "Check the status and history of your recent transfer requests",
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
