import 'package:flutter/material.dart';
import 'package:pashboi/features/public_home/pages/deposits_page/view/deposits_page.dart';
import 'package:pashboi/features/public_home/pages/loans_page/view/loans_page.dart';
import 'package:pashboi/features/public_home/pages/notices_page/view/notices_page.dart';
import 'package:pashboi/features/public_home/pages/services_page/view/services_page.dart';
import 'package:pashboi/features/public_home/pages/widgets/public_bottom_navigation_bar.dart';

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
      DepositsPae(),
      LoansPage(),
      ServicesPage(),
      NoticesPage(),
    ];
    return screens[selectedPage];
  }
}
