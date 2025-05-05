import 'package:flutter/material.dart';
import 'package:pashboi/features/deposit_policies/presentation/pages/deposit_policies_page.dart';
import 'package:pashboi/features/loan_policies/presentation/pages/loan_policies_page.dart';
import 'package:pashboi/features/notices/presentation/pages/notices_page.dart';
import 'package:pashboi/features/service_centers/presentation/pages/service_center_page.dart';
import 'package:pashboi/features/service_and_projects/presentation/pages/service_and_projects_page.dart';
import 'package:pashboi/features/public_home/widgets/public_bottom_navigation_bar.dart';

final ValueNotifier<int> publicSelectedPageNotifier = ValueNotifier(0);

class PublicHome extends StatefulWidget {
  const PublicHome({super.key});

  @override
  State<PublicHome> createState() => _PublicHomeState();
}

class _PublicHomeState extends State<PublicHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: publicSelectedPageNotifier,
        builder: (context, selectedPage, child) {
          return _getScreen(selectedPage);
        },
      ),
      bottomNavigationBar: const PublicBottomNavigationBar(),
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
