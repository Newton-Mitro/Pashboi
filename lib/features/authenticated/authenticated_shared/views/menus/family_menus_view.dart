import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FamilyMenusView extends StatefulWidget {
  final UserEntity authUser;

  const FamilyMenusView({super.key, required this.authUser});

  @override
  State<FamilyMenusView> createState() => _FamilyMenusViewState();
}

class _FamilyMenusViewState extends State<FamilyMenusView> {
  List<Map<String, dynamic>> getInfoMenus(BuildContext context) {
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    return [
      {
        "icon": Icon(FontAwesomeIcons.users, color: onPrimaryColor, size: 30),
        "menuName": Locales.string(
          context,
          "family_menu_family_&_relatives_title",
        ),
        "controllerName": "FamilyRelatives",
        "menuDescription": Locales.string(
          context,
          "family_menu_family_&_relatives_description",
        ),
        "route": AuthRoutesName.familyAndRelativesPage,
      },
      {
        "icon": Icon(
          FontAwesomeIcons.userPlus,
          color: onPrimaryColor,
          size: 30,
        ),
        "menuName": Locales.string(
          context,
          "family_menu_add_family_or_relatives_title",
        ),
        "controllerName": "AddFamilyMember",
        "menuDescription": Locales.string(
          context,
          "family_menu_add_family_or_relatives_description",
        ),
        "route": AuthRoutesName.addFamilyMemberPage,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final infoMenus = getInfoMenus(context);
    final rolePermissions = widget.authUser.rolePermissions;

    // Extract allowed controller names from rolePermissions
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
                    : null,
            isEnabled: isEnabled,
          );
        },
      ),
    );
  }
}
