import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/authenticated/authenticated_shared/widgets/bkash_icon.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DepositMenusView extends StatefulWidget {
  final UserEntity authUser;

  const DepositMenusView({super.key, required this.authUser});

  @override
  State<DepositMenusView> createState() => _DepositMenusViewState();
}

class _DepositMenusViewState extends State<DepositMenusView> {
  List<Map<String, dynamic>> getInfoMenus(BuildContext context) {
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    return [
      {
        "icon": Icon(
          FontAwesomeIcons.moneyBillWave,
          color: onPrimaryColor,
          size: 30,
        ),
        "menuName": Locales.string(context, "deposit_menu_deposit_now_title"),
        "controllerName": "DepositNow",
        "menuDescription": Locales.string(
          context,
          "deposit_menu_deposit_now_description",
        ),
        "route": AuthRoutesName.depositNowPage,
      },
      {
        "icon": BkashIcon(),
        "menuName": Locales.string(
          context,
          "deposit_menu_deposit_from_bkash_title",
        ),
        "controllerName": "DepositBkash",
        "menuDescription": Locales.string(
          context,
          "deposit_menu_deposit_from_bkash_description",
        ),
        "route": AuthRoutesName.depositFromBkashPage,
      },
      {
        "icon": Icon(FontAwesomeIcons.clock, color: onPrimaryColor, size: 30),
        "menuName": Locales.string(
          context,
          "deposit_menu_deposit_latter_title",
        ),
        "controllerName": "DepositLater",
        "menuDescription": Locales.string(
          context,
          "deposit_menu_deposit_latter_description",
        ),
        "route": AuthRoutesName.depositLaterPage,
      },
      {
        "icon": Icon(
          FontAwesomeIcons.circleInfo,
          color: onPrimaryColor,
          size: 30,
        ),
        "menuName": Locales.string(
          context,
          "deposit_menu_deposit_request_status_title",
        ),
        "controllerName": "DepositStatus",
        "menuDescription": Locales.string(
          context,
          "deposit_menu_deposit_request_status_description",
        ),
        "route": AuthRoutesName.depositRequestStatusPage,
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
                    : null,
            isEnabled: isEnabled, // all filtered menus are enabled
          );
        },
      ),
    );
  }
}
