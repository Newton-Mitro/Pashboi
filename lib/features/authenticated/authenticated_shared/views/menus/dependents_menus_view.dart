import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DependentsMenusView extends StatefulWidget {
  const DependentsMenusView({super.key});

  @override
  State<DependentsMenusView> createState() => _DependentsMenusViewState();
}

class _DependentsMenusViewState extends State<DependentsMenusView> {
  List<Map<String, dynamic>> getInfoMenus(BuildContext context) {
    final color = Theme.of(context).colorScheme.onPrimary;

    return [
      {
        "icon": Icon(FontAwesomeIcons.children, color: color, size: 30),
        "menuName": Locales.string(context, "info_menu_dependents_title"),
        "menuDescription": Locales.string(
          context,
          "info_menu_dependents_description",
        ),
        "route": AuthRoutesName.dependentsPage,
      },
      {
        "icon": Icon(FontAwesomeIcons.children, color: color, size: 30),
        "menuName": Locales.string(
          context,
          "info_menu_add_operating_account_title",
        ),
        "menuDescription": Locales.string(
          context,
          "info_menu_add_operating_account_description",
        ),
        "route": AuthRoutesName.addOperatingAccountPage,
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
