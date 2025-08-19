import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentMenusView extends StatefulWidget {
  final UserEntity authUser;

  const PaymentMenusView({super.key, required this.authUser});

  @override
  State<PaymentMenusView> createState() => _PaymentMenusViewState();
}

class _PaymentMenusViewState extends State<PaymentMenusView> {
  List<Map<String, dynamic>> getInfoMenus(BuildContext context) {
    final color = Theme.of(context).colorScheme.onPrimary;

    return [
      {
        "icon": Icon(FontAwesomeIcons.moneyCheckDollar, color: color, size: 30),
        "menuName": Locales.string(context, "payment_menu_payments_title"),
        "controllerName": "Payments", // added controllerName
        "menuDescription": Locales.string(
          context,
          "payment_menu_payments_description",
        ),
        "route": AuthRoutesName.paymentPage,
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
