import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/features/deposit_policies/presentation/pages/deposit_policies_page.dart';
import 'package:pashboi/features/loan_policies/presentation/pages/loan_policies_page.dart';
import 'package:pashboi/features/notices/presentation/pages/notices_page.dart';
import 'package:pashboi/features/service_centers/presentation/pages/service_center_page.dart';
import 'package:pashboi/features/service_and_projects/presentation/pages/service_and_projects_page.dart';
import 'package:pashboi/features/public_home/widgets/public_bottom_navigation_bar.dart';
import 'package:pashboi/features/public_home/widgets/public_home_drawer.dart';

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
      Locales.string(context, 'public_savings_page_title'),
      Locales.string(context, 'public_loans_page_title'),
      Locales.string(context, 'public_services_and_projects_page_title'),
      Locales.string(context, 'public_notices_page_title'),
      Locales.string(context, 'public_service_centers_page_title'),
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
