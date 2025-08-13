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
  List<Map<String, dynamic>> getInfoMenus(BuildContext context) {
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    return [
      {
        "icon": Icon(
          FontAwesomeIcons.circleUser,
          color: onPrimaryColor,
          size: 30,
        ),
        "menuName": Locales.string(context, "info_menu_profile_title"),
        "menuDescription": Locales.string(
          context,
          "info_menu_profile_description",
        ),
        "route": AuthRoutesName.profilePage,
      },
      {
        "icon": Icon(Icons.credit_card, color: onPrimaryColor, size: 30),
        "menuName": Locales.string(context, "info_menu_card_title"),
        "menuDescription": Locales.string(
          context,
          "info_menu_card_description",
        ),
        "route": AuthRoutesName.cardPage,
      },
      {
        "icon": Icon(
          FontAwesomeIcons.handshake,
          color: onPrimaryColor,
          size: 30,
        ),
        "menuName": "AGM Counter",
        "menuDescription": Locales.string(
          context,
          "info_menu_card_description",
        ),
        "route": AuthRoutesName.cardPage,
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
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final menu = infoMenus[index];
          return MenuCard(
            icon: menu['icon'],
            menuName: menu['menuName'],
            menuDescription: menu['menuDescription'],
            onTap: () => Navigator.pushNamed(context, menu['route']),
          );
        },
      ),
    );
  }
}
