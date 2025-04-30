import 'package:flutter/material.dart';
import 'package:pashboi/pages/public/deposits_page/views/deposits_page.dart';
import 'package:pashboi/pages/public/loans_page/views/loans_page.dart';
import 'package:pashboi/pages/public/notices_page/views/notices_page.dart';
import 'package:pashboi/pages/public/services_page/views/services_page.dart';
import 'package:pashboi/pages/public/home/widgets/public_bottom_navigation_bar.dart';

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
