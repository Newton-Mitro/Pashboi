import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoansMenusView extends StatefulWidget {
  const LoansMenusView({super.key});

  @override
  State<LoansMenusView> createState() => _LoansMenusViewState();
}

class _LoansMenusViewState extends State<LoansMenusView> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> infoMenus = [
      {
        "icon": FontAwesomeIcons.fileInvoiceDollar,
        "menuName": Locales.string(context, "loan_menu_my_loans_title"),
        "menuDescription": Locales.string(
          context,
          "loan_menu_my_loans_description",
        ),
        "route": AuthRoutesName.myLoansPage,
      },
      {
        "icon": FontAwesomeIcons.fileSignature,
        "menuName": Locales.string(context, "loan_menu_apply_for_a_loan_title"),
        "menuDescription": Locales.string(
          context,
          "loan_menu_apply_for_a_loan_description",
        ),
        "route": AuthRoutesName.myLoansPage,
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
