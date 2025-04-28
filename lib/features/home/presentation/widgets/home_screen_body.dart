import 'package:flutter/material.dart';
import 'package:pashboi/features/home/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:pashboi/features/home/presentation/notifier/notifiers.dart';
import 'package:pashboi/features/home/presentation/home_screen/view/inbox_screen.dart';
import 'package:pashboi/features/user/presentation/user_profile_screen/view/user_profile_screen.dart';

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
      const InboxScreen(),
      authUserNotifier.value != null
          ? UserProfileScreen(user: authUserNotifier.value!)
          : SizedBox.shrink(),
    ];
    return screens[selectedPage];
  }
}
