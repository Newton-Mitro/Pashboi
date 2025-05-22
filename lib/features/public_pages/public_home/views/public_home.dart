import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/features/public_pages/deposit_policies/presentation/pages/deposit_policies_page.dart';
import 'package:pashboi/features/public_pages/loan_policies/presentation/pages/loan_policies_page.dart';
import 'package:pashboi/features/public_pages/notices/presentation/pages/notices_page.dart';
import 'package:pashboi/features/public_pages/service_centers/presentation/pages/service_center_page.dart';
import 'package:pashboi/features/public_pages/service_and_projects/presentation/pages/service_and_projects_page.dart';
import 'package:pashboi/features/public_pages/public_home/widgets/public_bottom_navigation_bar.dart';
import 'package:pashboi/features/public_pages/public_home/widgets/public_home_drawer.dart';

final ValueNotifier<int> publicSelectedPageNotifier = ValueNotifier(0);

class PublicHome extends StatefulWidget {
  const PublicHome({super.key});

  @override
  State<PublicHome> createState() => _PublicHomeState();
}

class _PublicHomeState extends State<PublicHome> {
  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      Locales.string(context, 'public_bottom_nav_menu_savings'),
      Locales.string(context, 'public_bottom_nav_menu_loans'),
      Locales.string(context, 'public_bottom_nav_menu_services_and_projects'),
      Locales.string(context, 'public_bottom_nav_menu_notices'),
      Locales.string(context, 'public_bottom_nav_menu_service_centers'),
    ];

    return ValueListenableBuilder<int>(
      valueListenable: publicSelectedPageNotifier,
      builder: (context, selectedPage, child) {
        return Scaffold(
          appBar: AppBar(title: Text(titles[selectedPage])), // Dynamic title
          drawer: const PublicHomeDrawer(),
          body: _getScreen(selectedPage),
          bottomNavigationBar: const PublicBottomNavigationBar(),
        );
      },
    );
  }

  Widget _getScreen(int selectedPage) {
    final List<Widget> screens = [
      DepositPoliciesPage(),
      LoanPoliciesPage(),
      ServiceAndProjectsPage(),
      NoticesPage(),
      ServiceCenterPage(),
    ];
    return screens[selectedPage];
  }
}
