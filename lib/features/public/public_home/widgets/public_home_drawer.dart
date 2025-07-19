import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/constants/app_images.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/public/development_credits/presentation/pages/development_credits_page.dart';
import 'package:pashboi/features/public/pages/presentation/pages/about_us_page.dart';
import 'package:pashboi/features/public/pages/presentation/pages/founder_profile_page.dart';
import 'package:pashboi/features/public/pages/presentation/pages/mission_vision_page.dart';
import 'package:pashboi/features/public/pages/presentation/pages/policy_page.dart';
import 'package:pashboi/features/public/project/presentation/pages/project.dart';
import 'package:pashboi/features/public/service/presentation/service_page.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:flutter_locales/flutter_locales.dart';

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
            label: Locales.string(context, "side_menu_title_for_about_us"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
          ),
          _buildDrawerItem(
            context,
            icon: FontAwesomeIcons.userTie,
            label: Locales.string(
              context,
              "side_menu_title_for_founder_profile",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FounderProfilePage()),
              );
            },
          ),
          _buildDrawerItem(
            context,
            icon: FontAwesomeIcons.bullseye,
            label: Locales.string(
              context,
              "side_menu_title_for_mission_and_vision",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MissionAndVisionPage()),
              );
            },
          ),
          _buildDrawerItem(
            context,
            icon: FontAwesomeIcons.helmetUn,
            label: Locales.string(context, "side_menu_title_for_project"),
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
            label: Locales.string(context, "side_menu_title_for_services"),
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
            label: Locales.string(
              context,
              "side_menu_title_for_privacy_policy",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PolicyPage()),
              );
            },
          ),
          _buildDrawerItem(
            context,
            icon: FontAwesomeIcons.code,
            label: Locales.string(
              context,
              "side_menu_title_for_development_credits",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DevelopmentCreditsPage(),
                ),
              );
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
