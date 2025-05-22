import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/menu_tile.dart';
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
      },
      {
        "icon": FontAwesomeIcons.fileSignature,
        "menuName": Locales.string(context, "loan_menu_apply_for_a_loan_title"),
        "menuDescription": Locales.string(
          context,
          "loan_menu_apply_for_a_loan_description",
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
