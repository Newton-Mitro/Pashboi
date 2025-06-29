import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:pashboi/features/authenticated/authenticated_home/bloc/authenticated_home_bloc.dart';
import 'package:pashboi/features/authenticated/authenticated_home/widgets/base64_image_widget.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/routes/public_routes_name.dart';

class AuthenticatedHomeDrawer extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems;
  final UserEntity? user;

  const AuthenticatedHomeDrawer({
    super.key,
    required this.menuItems,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    final String? base64Image = user?.userPicture?.replaceFirst(
      'data:image/png;base64,',
      '',
    );

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              user?.userName ?? "User Name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.theme.colorScheme.onPrimary,
              ),
            ),
            accountEmail: Text(
              user?.loginEmail ?? "User Email",
              style: TextStyle(
                fontSize: 11,
                color: context.theme.colorScheme.onPrimary,
              ),
            ),
            currentAccountPicture: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.theme.colorScheme.onPrimary,
                    width: 2,
                  ),
                  image: DecorationImage(
                    image:
                        (base64Image != null && base64Image.isNotEmpty)
                            ? Base64ImageWidget(
                              base64String: base64Image,
                            ).imageProvider
                            : const NetworkImage(
                              'https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg',
                            ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ...menuItems.map(
                  (item) => _buildDrawerItem(
                    context,
                    icon: item['icon'],
                    label: item['label'],
                    onTap: () {
                      context.read<AuthenticatedHomeBloc>().add(
                        ChangePageEvent(item['index']),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                _buildDrawerItem(
                  context,
                  icon: FontAwesomeIcons.helmetSafety,
                  label: Locales.string(
                    context,
                    'auth_bottom_nav_menu_personnel',
                  ),
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(AuthRoutesName.personnelPage);
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
              ],
            ),
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: FontAwesomeIcons.rightFromBracket,
            label: "Logout",
            onTap: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
          ),
          const SizedBox(height: 30),
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
