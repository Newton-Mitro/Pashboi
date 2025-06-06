import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WithdrawMenusView extends StatefulWidget {
  const WithdrawMenusView({super.key});

  @override
  State<WithdrawMenusView> createState() => _WithdrawMenusViewState();
}

class _WithdrawMenusViewState extends State<WithdrawMenusView> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> infoMenus = [
      {
        "icon": FontAwesomeIcons.moneyBillWave,
        "menuName": Locales.string(
          context,
          "withdraw_menu_withdraw_through_atm_title",
        ),
        "menuDescription": Locales.string(
          context,
          "withdraw_menu_withdraw_through_atm_description",
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
          return MenuCard(
            iconData: menu['icon'],
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
