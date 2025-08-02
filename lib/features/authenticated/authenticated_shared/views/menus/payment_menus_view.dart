import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentMenusView extends StatefulWidget {
  const PaymentMenusView({super.key});

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
        "menuDescription": Locales.string(
          context,
          "payment_menu_payments_description",
        ),
        // Add "route": AuthRoutesName.somePage, if you want navigation
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final infoMenus = getInfoMenus(context);

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
              debugPrint("Tapped on ${menu['menuName']}");
            },
          );
        },
      ),
    );
  }
}
