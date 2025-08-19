import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoMenusView extends StatefulWidget {
  final UserEntity authUser;
  const InfoMenusView({super.key, required this.authUser});

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
        "controllerName": "Me",
        "menuDescription": Locales.string(
          context,
          "info_menu_profile_description",
        ),
        "route": AuthRoutesName.profilePage,
      },
      {
        "icon": Icon(Icons.credit_card, color: onPrimaryColor, size: 30),
        "menuName": Locales.string(context, "info_menu_card_title"),
        "controllerName": "Cards",
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
        "menuName": Locales.string(context, "info_menu_agm_counter_title"),
        "controllerName": "AGM Counter",
        "menuDescription": Locales.string(
          context,
          "info_menu_agm_counter_description",
        ),
        "route": AuthRoutesName.cardPage,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final infoMenus = getInfoMenus(context);

    final rolePermissions = widget.authUser.rolePermissions;

    // Extract all allowed controller names
    final allowedControllers =
        rolePermissions
            .map((p) => p.controllerName)
            .whereType<String>()
            .toSet();

    return SafeArea(
      child: ListView.separated(
        itemCount: infoMenus.length,
        padding: const EdgeInsets.all(12),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final menu = infoMenus[index];
          final controllerName = menu['controllerName'] as String?;
          final isEnabled =
              controllerName != null &&
              allowedControllers.contains(controllerName);

          return MenuCard(
            icon: menu['icon'],
            menuName: menu['menuName'],
            menuDescription: menu['menuDescription'],
            onTap:
                isEnabled
                    ? () => Navigator.pushNamed(context, menu['route'])
                    : null, // disabled if not allowed
            isEnabled:
                isEnabled, // you may need to update MenuCard to handle this
          );
        },
      ),
    );
  }
}
