import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/menu_card.dart';

class SuretyMenusView extends StatefulWidget {
  final UserEntity authUser;

  const SuretyMenusView({super.key, required this.authUser});

  @override
  State<SuretyMenusView> createState() => _SuretyMenusViewState();
}

class _SuretyMenusViewState extends State<SuretyMenusView> {
  List<Map<String, dynamic>> getInfoMenus(BuildContext context) {
    final color = Theme.of(context).colorScheme.onPrimary;

    return [
      {
        "icon": Icon(Icons.shield_moon, color: color, size: 30),
        "menuName": Locales.string(context, "surety_menu_given_sureties_title"),
        "controllerName": "Me",
        "menuDescription": Locales.string(
          context,
          "surety_menu_given_sureties_description",
        ),
        "route": AuthRoutesName.givenSuretiesPage,
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
        separatorBuilder: (context, index) => const SizedBox(height: 12),
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
                    : null, // disable tap if not allowed
            isEnabled: isEnabled, // pass to MenuCard for greying out
          );
        },
      ),
    );
  }
}
