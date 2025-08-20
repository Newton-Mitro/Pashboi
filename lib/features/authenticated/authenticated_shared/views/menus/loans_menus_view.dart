import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/menu_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoansMenusView extends StatefulWidget {
  final UserEntity authUser;

  const LoansMenusView({super.key, required this.authUser});

  @override
  State<LoansMenusView> createState() => _LoansMenusViewState();
}

class _LoansMenusViewState extends State<LoansMenusView> {
  List<Map<String, dynamic>> getInfoMenus(BuildContext context) {
    final color = Theme.of(context).colorScheme.onPrimary;

    return [
      {
        "icon": Icon(
          FontAwesomeIcons.fileInvoiceDollar,
          color: color,
          size: 30,
        ),
        "menuName": Locales.string(context, "loan_menu_my_loans_title"),
        "controllerName": "Loans",
        "menuDescription": Locales.string(
          context,
          "loan_menu_my_loans_description",
        ),
        "route": AuthRoutesName.myLoansPage,
      },
      {
        "icon": Icon(FontAwesomeIcons.fileSignature, color: color, size: 30),
        "menuName": Locales.string(context, "loan_menu_apply_for_a_loan_title"),
        "controllerName": "Apply for Loan", // added controllerName
        "menuDescription": Locales.string(
          context,
          "loan_menu_apply_for_a_loan_description",
        ),
        "route": AuthRoutesName.myLoansPage,
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
            isEnabled: isEnabled,
          );
        },
      ),
    );
  }
}
