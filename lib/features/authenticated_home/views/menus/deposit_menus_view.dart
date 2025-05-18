import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/menu_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DepositMenusView extends StatefulWidget {
  const DepositMenusView({super.key});

  @override
  State<DepositMenusView> createState() => _DepositMenusViewState();
}

class _DepositMenusViewState extends State<DepositMenusView> {
  final List<Map<String, dynamic>> infoMenus = [
    {
      "icon": FontAwesomeIcons.moneyBillWave,
      "menuName": "Deposit Now",
      "menuDescription":
          "Make an instant deposit to your account using available  methods",
    },
    {
      "icon": FontAwesomeIcons.clock,
      "menuName": "Deposit Later",
      "menuDescription":
          "Schedule a deposit for a later time or choose a future deposit option",
    },
    {
      "icon": FontAwesomeIcons.mobileScreenButton,
      "menuName": "Deposit from bKash",
      "menuDescription":
          "Easily deposit funds to your account directly through your bKash wallet",
    },
    {
      "icon": FontAwesomeIcons.circleInfo,
      "menuName": "Deposit Request Status",
      "menuDescription":
          "Track the status of your deposit requests and view related updates",
    },
    {
      "icon": FontAwesomeIcons.receipt,
      "menuName": "eReceipt",
      "menuDescription":
          "Access and download electronic receipts for your transactions",
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
