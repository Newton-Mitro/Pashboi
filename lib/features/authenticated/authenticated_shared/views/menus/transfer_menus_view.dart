import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/authenticated/authenticated_shared/widgets/bkash_icon.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransferMenusView extends StatefulWidget {
  final UserEntity authUser;

  const TransferMenusView({super.key, required this.authUser});

  @override
  State<TransferMenusView> createState() => _TransferMenusViewState();
}

class _TransferMenusViewState extends State<TransferMenusView> {
  List<Map<String, dynamic>> _buildInfoMenus(BuildContext context) {
    final color = Theme.of(context).colorScheme.onPrimary;

    return [
      {
        "icon": Icon(FontAwesomeIcons.rightLeft, color: color, size: 30),
        "menuName": Locales.string(
          context,
          "transfer_menu_transfer_within_dhaka_cradit_title",
        ),
        "controllerName": "Transfer Within Dhaka Credit",
        "menuDescription": Locales.string(
          context,
          "transfer_menu_transfer_within_dhaka_cradit_description",
        ),
        "route": AuthRoutesName.internalTransferPage,
      },
      {
        "icon": BkashIcon(),
        "menuName": Locales.string(
          context,
          "transfer_menu_transfer_to_bkash_title",
        ),
        "controllerName": "Transfer To bKash",
        "menuDescription": Locales.string(
          context,
          "transfer_menu_transfer_to_bkash_description",
        ),
        "route": AuthRoutesName.transferToBkashPage,
      },
      {
        "icon": Icon(FontAwesomeIcons.buildingColumns, color: color, size: 30),
        "menuName": Locales.string(
          context,
          "transfer_menu_bank_to_dhaka_cradit_title",
        ),
        "controllerName": "Bank To Dhaka Credit",
        "menuDescription": Locales.string(
          context,
          "transfer_menu_bank_to_dhaka_cradit_description",
        ),
        "route": AuthRoutesName.bankToDcTransferPage,
      },
      {
        "icon": Icon(FontAwesomeIcons.clipboardCheck, color: color, size: 30),
        "menuName": Locales.string(
          context,
          "transfer_menu_transfer_request_status_title",
        ),
        "controllerName": "Transfer Request Status",
        "menuDescription": Locales.string(
          context,
          "transfer_menu_transfer_request_status_description",
        ),
        "route": AuthRoutesName.bankToDcTransferStatusPage,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final infoMenus = _buildInfoMenus(context);
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
            onTap: () => Navigator.pushNamed(context, menu['route']),
            isEnabled: isEnabled,
          );
        },
      ),
    );
  }
}
