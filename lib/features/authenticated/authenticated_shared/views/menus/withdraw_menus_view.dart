import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WithdrawMenusView extends StatefulWidget {
  const WithdrawMenusView({super.key});

  @override
  State<WithdrawMenusView> createState() => _WithdrawMenusViewState();
}

class _WithdrawMenusViewState extends State<WithdrawMenusView> {
  List<Map<String, dynamic>> _getWithdrawInfoMenus(BuildContext context) {
    final color = Theme.of(context).colorScheme.onPrimary;

    return [
      {
        "icon": Icon(FontAwesomeIcons.moneyBillWave, color: color, size: 30),
        "menuName": Locales.string(
          context,
          "withdraw_menu_withdraw_through_atm_title",
        ),
        "menuDescription": Locales.string(
          context,
          "withdraw_menu_withdraw_through_atm_description",
        ),
        "route": AuthRoutesName.withdrawlQrPage,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final infoMenus = _getWithdrawInfoMenus(context);

    return SafeArea(
      child: ListView.separated(
        itemCount: infoMenus.length,
        padding: const EdgeInsets.all(12),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
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
