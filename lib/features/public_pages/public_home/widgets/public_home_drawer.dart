import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/constants/app_images.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class PublicHomeDrawer extends StatelessWidget {
  const PublicHomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "Dhaka Credit",
              style: TextStyle(
                fontSize: 16,
                color: context.theme.colorScheme.onPrimary,
              ),
            ),
            accountEmail: Text(
              "Employment Creation is Our Goal; \nSelf-Reliant Community is Our Dream.",
              style: TextStyle(
                fontSize: 12,
                color: context.theme.colorScheme.onPrimary,
              ),
            ),
            currentAccountPicture: Image.asset(
              AppImages.pathLogo,
              color: Colors.white,
            ),
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.circleInfo, size: 16),
            title: Text(
              "About Us",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: context.theme.colorScheme.onSurface,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.userTie, size: 16),
            title: Text(
              "Founders Profile",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: context.theme.colorScheme.onSurface,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.bullseye, size: 16),
            title: Text(
              "Mission and Vision",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: context.theme.colorScheme.onSurface,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.userShield, size: 16),
            title: Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: context.theme.colorScheme.onSurface,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.code, size: 16),
            title: Text(
              "Development Credits",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: context.theme.colorScheme.onSurface,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.bolt, size: 16),
            title: Text(
              "Powered By",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: context.theme.colorScheme.onSurface,
              ),
            ),
            onTap: () {},
          ),
          const Spacer(),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.houseChimney, size: 16),
            title: Text(
              "Home",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: context.theme.colorScheme.onSurface,
              ),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
