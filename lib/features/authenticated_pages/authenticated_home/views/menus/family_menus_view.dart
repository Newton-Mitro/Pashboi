import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FamilyMenusView extends StatefulWidget {
  const FamilyMenusView({super.key});

  @override
  State<FamilyMenusView> createState() => _FamilyMenusViewState();
}

class _FamilyMenusViewState extends State<FamilyMenusView> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> infoMenus = [
      {
        "icon": FontAwesomeIcons.users,
        "menuName": Locales.string(
          context,
          "family_menu_family_&_relatives_title",
        ),
        "menuDescription": Locales.string(
          context,
          "family_menu_family_&_relatives_description",
        ),
      },
      {
        "icon": FontAwesomeIcons.userPlus,
        "menuName": Locales.string(
          context,
          "family_menu_add_family_or_relatives_title",
        ),
        "menuDescription": Locales.string(
          context,
          "family_menu_add_family_or_relatives_description",
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
