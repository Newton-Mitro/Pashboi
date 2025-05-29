import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoMenusView extends StatefulWidget {
  const InfoMenusView({super.key});

  @override
  State<InfoMenusView> createState() => _InfoMenusViewState();
}
// <i class="fa-solid fa-users-gear"></i>

class _InfoMenusViewState extends State<InfoMenusView> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> infoMenus = [
      {
        "icon": FontAwesomeIcons.circleUser,
        "menuName": Locales.string(context, "info_menu_profile_title"),
        "menuDescription": Locales.string(
          context,
          "info_menu_profile_description",
        ),
      },
      {
        "icon": FontAwesomeIcons.userShield,
        "menuName": Locales.string(context, "info_menu_surety_status_title"),
        "menuDescription": Locales.string(
          context,
          "info_menu_surety_status_description",
        ),
      },
      {
        "icon": Icons.credit_card,
        "menuName": Locales.string(context, "info_menu_card_title"),
        "menuDescription": Locales.string(
          context,
          "info_menu_card_description",
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
