import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/constants/app_images.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/routes/public_routes_name.dart';

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
                fontWeight: FontWeight.bold,
                color: context.theme.colorScheme.onPrimary,
              ),
            ),
            accountEmail: Text(
              "Employment Creation is Our Goal; \nSelf-Reliant Community is Our Dream.",
              style: TextStyle(
                fontSize: 11,
                color: context.theme.colorScheme.onPrimary,
              ),
            ),
            currentAccountPicture: Image.asset(
              AppImages.pathLogo,
              color: Colors.white,
            ),
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.circleInfo),
            title: Text(
              "About Us",
              style: TextStyle(color: context.theme.colorScheme.onSurface),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.userTie),
            title: Text(
              "Founders Profile",
              style: TextStyle(color: context.theme.colorScheme.onSurface),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.bullseye),
            title: Text(
              "Mission and Vision",
              style: TextStyle(color: context.theme.colorScheme.onSurface),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.helmetUn),
            title: Text(
              "Projects",
              style: TextStyle(color: context.theme.colorScheme.onSurface),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.personBiking),
            title: Text(
              "Services",
              style: TextStyle(color: context.theme.colorScheme.onSurface),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.userShield),
            title: Text(
              "Privacy Policy",
              style: TextStyle(color: context.theme.colorScheme.onSurface),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.code),
            title: Text(
              "Development Credits",
              style: TextStyle(color: context.theme.colorScheme.onSurface),
            ),
            onTap: () {
              Navigator.of(
                context,
              ).pushNamed(PublicRoutesName.developmentCreditsPage);
            },
          ),

          const Spacer(),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.houseChimney),
            title: Text(
              "Home",
              style: TextStyle(color: context.theme.colorScheme.onSurface),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(PublicRoutesName.landingPage);
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
