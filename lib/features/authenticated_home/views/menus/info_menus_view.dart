import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/menu_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoMenusView extends StatefulWidget {
  const InfoMenusView({super.key});

  @override
  State<InfoMenusView> createState() => _InfoMenusViewState();
}
// <i class="fa-solid fa-users-gear"></i>

class _InfoMenusViewState extends State<InfoMenusView> {
  final List<Map<String, dynamic>> infoMenus = [
    {
      "icon": FontAwesomeIcons.usersGear,
      "menuName": "Dependent’s Account’s",
      "menuDescription":
          "Place for all your dependent accounts. You always add more.",
    },
    {
      "icon": FontAwesomeIcons.users,
      "menuName": "Family & Relative’s",
      "menuDescription":
          "Add your family members and relatives as a relation from here",
    },
    {
      "icon": FontAwesomeIcons.fileLines,
      "menuName": "Surety Status",
      "menuDescription":
          "See and manage all your accounts, statements from here. One place for all",
    },
    {
      "icon": Icons.settings,
      "menuName": "Beneficiarie’s",
      "menuDescription":
          "Manage and add beneficiaries for your account or services from here",
    },
    {
      "icon": Icons.support_agent,
      "menuName": "Card’s",
      "menuDescription": "View, manage, and request your  cards from here",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.separated(
          itemCount: infoMenus.length,
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
      ),
    );
  }
}
