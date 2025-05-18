import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/menu_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoansMenusView extends StatefulWidget {
  const LoansMenusView({super.key});

  @override
  State<LoansMenusView> createState() => _LoansMenusViewState();
}

class _LoansMenusViewState extends State<LoansMenusView> {
  final List<Map<String, dynamic>> infoMenus = [
    {
      "icon": FontAwesomeIcons.fileInvoiceDollar,
      "menuName": "My Loans",
      "menuDescription":
          "View details of your active loans,  outstanding balances",
    },
    {
      "icon": FontAwesomeIcons.fileSignature,
      "menuName": "Apply for a Loan",
      "menuDescription":
          "Submit a new loan application and check your eligibility and loan options",
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
