import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/authenticated_shared/widgets/bkash_icon.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransferMenusView extends StatefulWidget {
  const TransferMenusView({super.key});

  @override
  State<TransferMenusView> createState() => _TransferMenusViewState();
}

class _TransferMenusViewState extends State<TransferMenusView> {
  List<Map<String, dynamic>> _buildInfoMenus(BuildContext context) {
    final color = Theme.of(context).colorScheme.onPrimary;

    return [
      {
        "icon": BkashIcon(color: context.theme.colorScheme.onPrimary),
        "menuName": Locales.string(
          context,
          "transfer_menu_transfer_to_bkash_title",
        ),
        "menuDescription": Locales.string(
          context,
          "transfer_menu_transfer_to_bkash_description",
        ),
        "route": AuthRoutesName.transferToBkashPage,
      },
      {
        "icon": Icon(FontAwesomeIcons.rightLeft, color: color, size: 30),
        "menuName": Locales.string(
          context,
          "transfer_menu_transfer_within_dhaka_cradit_title",
        ),
        "menuDescription": Locales.string(
          context,
          "transfer_menu_transfer_within_dhaka_cradit_description",
        ),
        "route": AuthRoutesName.internalTransferPage,
      },
      {
        "icon": Icon(FontAwesomeIcons.buildingColumns, color: color, size: 30),
        "menuName": Locales.string(
          context,
          "transfer_menu_bank_to_dhaka_cradit_title",
        ),
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
        "menuDescription": Locales.string(
          context,
          "transfer_menu_transfer_request_status_description",
        ),
        // "route": AuthRoutesName.transferRequestStatusPage,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final infoMenus = _buildInfoMenus(context);

    return SafeArea(
      child: ListView.separated(
        itemCount: infoMenus.length,
        padding: const EdgeInsets.all(12),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
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
