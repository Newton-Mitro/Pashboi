import 'package:flutter/material.dart';
import 'package:pashboi/features/authenticated_home/widgets/app_bottom_navigation_bar.dart';
import 'package:pashboi/features/authenticated_home/notifier/notifiers.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return SizedBox.shrink();
        },
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }
}
