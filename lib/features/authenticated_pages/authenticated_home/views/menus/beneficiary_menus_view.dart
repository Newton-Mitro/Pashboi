import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/menu_card.dart';
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
        "route": AuthRoutesName.beneficiariesPage,
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
        "route": AuthRoutesName.addBeneficiaryPage,
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
