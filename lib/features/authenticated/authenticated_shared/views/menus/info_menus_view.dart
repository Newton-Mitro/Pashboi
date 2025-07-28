import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoMenusView extends StatefulWidget {
  const InfoMenusView({super.key});

  @override
  State<InfoMenusView> createState() => _InfoMenusViewState();
}

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
        "route": AuthRoutesName.profilePage,
      },
      {
        "icon": FontAwesomeIcons.children,
        "menuName": Locales.string(context, "accounts_menu_dependents_title"),
        "menuDescription": Locales.string(
          context,
          "accounts_menu_dependents_description",
        ),
        "route": AuthRoutesName.dependentsPage,
      },
      {
        "icon": FontAwesomeIcons.children,
        "menuName": 'Add Operating Account',
        "menuDescription": Locales.string(
          context,
          "accounts_menu_dependents_description",
        ),
        "route": AuthRoutesName.addOperatingAccountPage,
      },
      {
        "icon": Icons.credit_card,
        "menuName": Locales.string(context, "info_menu_card_title"),
        "menuDescription": Locales.string(
          context,
          "info_menu_card_description",
        ),
        "route": AuthRoutesName.cardPage,
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
