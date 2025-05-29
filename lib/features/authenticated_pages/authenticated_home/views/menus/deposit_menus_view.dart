import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DepositMenusView extends StatefulWidget {
  const DepositMenusView({super.key});

  @override
  State<DepositMenusView> createState() => _DepositMenusViewState();
}

class _DepositMenusViewState extends State<DepositMenusView> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> infoMenus = [
      {
        "icon": FontAwesomeIcons.moneyBillWave,
        "menuName": Locales.string(context, "deposit_menu_deposit_now_title"),
        "menuDescription": Locales.string(
          context,
          "deposit_menu_deposit_now_description",
        ),
      },
      {
        "icon": FontAwesomeIcons.clock,
        "menuName": Locales.string(
          context,
          "deposit_menu_deposit_latter_title",
        ),
        "menuDescription": Locales.string(
          context,
          "deposit_menu_deposit_latter_description",
        ),
      },
      {
        "icon": FontAwesomeIcons.mobileScreenButton,
        "menuName": Locales.string(
          context,
          "deposit_menu_deposit_from_bkash_title",
        ),
        "menuDescription": Locales.string(
          context,
          "deposit_menu_deposit_from_bkash_description",
        ),
      },
      {
        "icon": FontAwesomeIcons.circleInfo,
        "menuName": Locales.string(
          context,
          "deposit_menu_deposit_request_status_title",
        ),
        "menuDescription": Locales.string(
          context,
          "deposit_menu_deposit_request_status_description",
        ),
      },
      {
        "icon": FontAwesomeIcons.receipt,
        "menuName": Locales.string(context, "deposit_menu_ereceipt_title"),
        "menuDescription": Locales.string(
          context,
          "deposit_menu_ereceipt_description",
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
