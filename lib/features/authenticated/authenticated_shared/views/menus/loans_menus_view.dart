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
  List<Map<String, dynamic>> getInfoMenus(BuildContext context) {
    final color = Theme.of(context).colorScheme.onPrimary;

    return [
      {
        "icon": Icon(
          FontAwesomeIcons.fileInvoiceDollar,
          color: color,
          size: 30,
        ),
        "menuName": Locales.string(context, "loan_menu_my_loans_title"),
        "menuDescription": Locales.string(
          context,
          "loan_menu_my_loans_description",
        ),
        "route": AuthRoutesName.myLoansPage,
      },
      {
        "icon": Icon(FontAwesomeIcons.fileSignature, color: color, size: 30),
        "menuName": Locales.string(context, "loan_menu_apply_for_a_loan_title"),
        "menuDescription": Locales.string(
          context,
          "loan_menu_apply_for_a_loan_description",
        ),
        "route": AuthRoutesName.myLoansPage,
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
