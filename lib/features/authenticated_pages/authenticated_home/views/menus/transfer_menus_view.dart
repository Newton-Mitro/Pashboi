import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransferMenusView extends StatefulWidget {
  const TransferMenusView({super.key});

  @override
  State<TransferMenusView> createState() => _TransferMenusViewState();
}

class _TransferMenusViewState extends State<TransferMenusView> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> infoMenus = [
      {
        "icon": FontAwesomeIcons.mobileScreenButton,
        "menuName": Locales.string(
          context,
          "transfer_menu_transfer_to_bkash_title",
        ),
        "menuDescription": Locales.string(
          context,
          "transfer_menu_transfer_to_bkash_description",
        ),
      },
      {
        "icon": FontAwesomeIcons.rightLeft,
        "menuName": Locales.string(
          context,
          "transfer_menu_transfer_within_dhaka_cradit_title",
        ),
        "menuDescription": Locales.string(
          context,
          "transfer_menu_transfer_within_dhaka_cradit_description",
        ),
      },
      {
        "icon": FontAwesomeIcons.buildingColumns,
        "menuName": Locales.string(
          context,
          "transfer_menu_bank_to_dhaka_cradit_title",
        ),
        "menuDescription": Locales.string(
          context,
          "transfer_menu_bank_to_dhaka_cradit_description",
        ),
      },

      {
        "icon": FontAwesomeIcons.clipboardCheck,
        "menuName": Locales.string(
          context,
          "transfer_menu_transfer_request_status_title",
        ),
        "menuDescription": Locales.string(
          context,
          "transfer_menu_transfer_request_status_description",
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
