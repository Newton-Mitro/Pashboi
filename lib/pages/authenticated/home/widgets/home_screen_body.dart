import 'package:flutter/material.dart';
import 'package:pashboi/pages/authenticated/home/widgets/app_bottom_navigation_bar.dart';
import 'package:pashboi/pages/authenticated/home/notifier/notifiers.dart';
import 'package:pashboi/pages/authenticated/profile_page/views/profile_page.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return _getScreen(selectedPage);
        },
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }

  Widget _getScreen(int selectedPage) {
    final List<Widget> screens = [
      authUserNotifier.value != null
          ? ProfilePage(user: authUserNotifier.value!)
          : SizedBox.shrink(),
    ];
    return screens[selectedPage];
  }
}
