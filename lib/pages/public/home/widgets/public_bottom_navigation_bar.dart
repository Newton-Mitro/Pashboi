import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
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
                label: Locales.string(
                  context,
                  'public_bottom_nav_menu_savings',
                ),
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.sackDollar,
                ), // Icon color for Profile
                label: Locales.string(context, 'public_bottom_nav_menu_loans'),
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.userNurse,
                ), // Icon color for Notifications
                label: Locales.string(
                  context,
                  'public_bottom_nav_menu_services_and_projects',
                ),
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.bell), // Icon color for Search
                label: Locales.string(
                  context,
                  'public_bottom_nav_menu_notices',
                ),
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.locationDot,
                ), // Icon color for Search
                label: Locales.string(
                  context,
                  'public_bottom_nav_menu_service_centers',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
