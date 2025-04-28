import 'package:flutter/material.dart';
import 'package:pashboi/core/utils/app_context.dart';
import 'package:pashboi/core/widgets/language_selector/language_selector.dart';
import 'package:pashboi/core/widgets/theme_switcher/theme_switcher.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(60); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        title: Text(context.appLocalizations.appName),
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove default shadow
        actions: [
          LanguageSelector(),
          ThemeSwitcher(),
          // PopupMenuButton(
          //   itemBuilder: (context) {
          //     return [
          //       PopupMenuItem(value: "settings", child: Text("Settings")),
          //       PopupMenuItem(value: "logout", child: Text("Logout")),
          //     ];
          //   },
          // ),
        ],
      ),
    );
  }
}
