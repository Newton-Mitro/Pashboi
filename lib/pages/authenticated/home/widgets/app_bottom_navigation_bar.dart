import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/utils/app_context.dart';
import 'package:pashboi/pages/authenticated/home/notifier/notifiers.dart';
import 'package:pashboi/pages/authenticated/home/widgets/bottom_sheet.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
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
              if (value > 0) {
                if (accessTokenNotifier.value != null) {
                  selectedPageNotifier.value = value;
                } else {
                  showCustomBottomSheet(context);
                }
              } else {
                selectedPageNotifier.value = value;
              }
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.chartSimple,
                ), // Icon color for Home
                label: context.appLocalizations.info,
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.umbrella,
                ), // Icon color for Profile
                label: context.appLocalizations.accounts,
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.piggyBank,
                ), // Icon color for Notifications
                label: context.appLocalizations.depositManagement,
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.moneyBillTransfer,
                ), // Icon color for Search
                label: context.appLocalizations.transferMoney,
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.sackDollar,
                ), // Icon color for Settings
                label: "Acc. Mgmt.",
              ),
            ],
          ),
        );
      },
    );
  }
}
