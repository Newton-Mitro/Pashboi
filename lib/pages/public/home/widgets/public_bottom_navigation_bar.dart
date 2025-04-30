import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/utils/app_context.dart';
import 'package:pashboi/pages/public/home/views/public_home.dart';

class PublicBottomNavigationBar extends StatelessWidget {
  const PublicBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: publicSelectedPageNotifier,
      builder: (context, selectedPage, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.theme.colorScheme.primary,
                context.theme.colorScheme.primary,
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 1.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: selectedPage,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              publicSelectedPageNotifier.value = value;
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.piggyBank), // Icon color for Home
                label: context.appLocalizations.savings,
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.sackDollar,
                ), // Icon color for Profile
                label: context.appLocalizations.loans,
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.userNurse,
                ), // Icon color for Notifications
                label: context.appLocalizations.sercives,
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.bell), // Icon color for Search
                label: context.appLocalizations.notices,
              ),
            ],
          ),
        );
      },
    );
  }
}
