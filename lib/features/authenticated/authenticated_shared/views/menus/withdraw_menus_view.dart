import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WithdrawMenusView extends StatefulWidget {
  final UserEntity authUser;

  const WithdrawMenusView({super.key, required this.authUser});

  @override
  State<WithdrawMenusView> createState() => _WithdrawMenusViewState();
}

class _WithdrawMenusViewState extends State<WithdrawMenusView> {
  List<Map<String, dynamic>> _getWithdrawInfoMenus(BuildContext context) {
    final color = Theme.of(context).colorScheme.onPrimary;

    return [
      {
        "icon": Icon(FontAwesomeIcons.moneyBillWave, color: color, size: 30),
        "menuName": Locales.string(
          context,
          "withdraw_menu_withdraw_through_atm_title",
        ),
        "controllerName": "Through ATM", // added controllerName
        "menuDescription": Locales.string(
          context,
          "withdraw_menu_withdraw_through_atm_description",
        ),
        "route": AuthRoutesName.withdrawlQrPage,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final infoMenus = _getWithdrawInfoMenus(context);
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
