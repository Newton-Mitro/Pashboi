import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/menu_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BeneficiaryMenusView extends StatefulWidget {
  const BeneficiaryMenusView({super.key});

  @override
  State<BeneficiaryMenusView> createState() => _BeneficiaryMenusViewState();
}

class _BeneficiaryMenusViewState extends State<BeneficiaryMenusView> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> infoMenus = [
      {
        "icon": FontAwesomeIcons.users,
        "menuName": Locales.string(
          context,
          "beneficiary_menu_beneficiaries_title",
        ),
        "menuDescription": Locales.string(
          context,
          "beneficiary_menu_beneficiaries_description",
        ),
      },
      {
        "icon": FontAwesomeIcons.userPlus,
        "menuName": Locales.string(
          context,
          "beneficiary_menu_add_beneficiaries_title",
        ),
        "menuDescription": Locales.string(
          context,
          "beneficiary_menu_add_beneficiaries_description",
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
    );
  }
}
