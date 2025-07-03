import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/constants/app_images.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/public/project/presentation/pages/project.dart';
import 'package:pashboi/features/public/service/presentation/service_page.dart';
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
              "Employment Creation is Our Goal;\nSelf-Reliant Community is Our Dream.",
              style: TextStyle(
                fontSize: 11,
                color: context.theme.colorScheme.onPrimary,
              ),
            ),
            currentAccountPicture: Image.asset(
              AppImages.pathLogo,
              color: context.theme.colorScheme.onPrimary,
            ),
          ),
          _buildDrawerItem(
            context,
            icon: FontAwesomeIcons.circleInfo,
            label: "About Us",
            onTap: () {
              // TODO: Add navigation or logic
            },
          ),
          _buildDrawerItem(
            context,
            icon: FontAwesomeIcons.userTie,
            label: "Founders Profile",
            onTap: () {
              // TODO: Add navigation or logic
            },
          ),
          _buildDrawerItem(
            context,
            icon: FontAwesomeIcons.bullseye,
            label: "Mission and Vision",
            onTap: () {
              // TODO: Add navigation or logic
            },
          ),
          _buildDrawerItem(
            context,
            icon: FontAwesomeIcons.helmetUn,
            label: "Projects",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProjectPage()),
              );
            },
          ),
          _buildDrawerItem(
            context,
            icon: FontAwesomeIcons.personBiking,
            label: "Services",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ServicePage()),
              );
            },
          ),
          _buildDrawerItem(
            context,
            icon: FontAwesomeIcons.userShield,
            label: "Privacy Policy",
            onTap: () {
              // TODO: Add navigation or logic
            },
          ),
          _buildDrawerItem(
            context,
            icon: FontAwesomeIcons.code,
            label: "Development Credits",
            onTap: () {
              Navigator.of(
                context,
              ).pushNamed(PublicRoutesName.developmentCreditsPage);
            },
          ),
          const Spacer(),
          Divider(height: 1),
          _buildDrawerItem(
            context,
            icon: FontAwesomeIcons.houseChimney,
            label: "Home",
            onTap: () {
              Navigator.of(context).pushNamed(PublicRoutesName.landingPage);
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: FaIcon(icon, color: context.theme.iconTheme.color),
      title: Text(
        label,
        style: TextStyle(color: context.theme.colorScheme.onSurface),
      ),
      onTap: onTap,
    );
  }
}
