import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/features/authenticated_home/notifier/notifiers.dart';
import 'package:pashboi/features/authenticated_home/widgets/app_bottom_navigation_bar.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/authenticated_home/bloc/auth_bloc.dart';
import 'package:pashboi/shared/widgets/app_background.dart';

class AuthenticatedHome extends StatefulWidget {
  const AuthenticatedHome({super.key});

  @override
  State<AuthenticatedHome> createState() => _AuthenticatedHomeState();
}

class _AuthenticatedHomeState extends State<AuthenticatedHome> {
  Future<bool> _showLogoutDialog() async {
    return await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Logout'),
                  ),
                ],
              ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => sl<AuthBloc>())],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.pushReplacementNamed(context, PublicRoutesName.root);
          }
        },
        child: PopScope(
          canPop: false, // control pop manually
          onPopInvoked: (didPop) async {
            if (!didPop) {
              final shouldLogout = await _showLogoutDialog();
              if (shouldLogout) {
                context.read<AuthBloc>().add(LogoutEvent());
              }
            }
          },
          child: ValueListenableBuilder<int>(
            valueListenable: selectedPageNotifier,
            builder:
                (context, selectedPage, child) => Scaffold(
                  appBar: AppBar(
                    // leading: Image.asset(AppImages.pathLogo),
                    automaticallyImplyLeading: false,
                    title: const Text('Info'),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    elevation: 4,
                    actions: [
                      PopupMenuButton<int>(
                        offset: const Offset(0, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onSelected: (value) async {
                          if (value == 0) {
                            // Handle Profile
                            debugPrint('Profile tapped');
                          } else if (value == 1) {
                            // Handle Settings
                            debugPrint('Settings tapped');
                          } else if (value == 2) {
                            final shouldLogout = await _showLogoutDialog();
                            if (shouldLogout) {
                              context.read<AuthBloc>().add(LogoutEvent());
                            }
                          }
                        },
                        itemBuilder:
                            (context) => [
                              const PopupMenuItem(
                                value: 0,
                                child: Row(
                                  children: [
                                    Icon(Icons.person, size: 20),
                                    SizedBox(width: 8),
                                    Text('Profile'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                value: 1,
                                child: Row(
                                  children: [
                                    Icon(Icons.settings, size: 20),
                                    SizedBox(width: 8),
                                    Text('Settings'),
                                  ],
                                ),
                              ),
                              // Custom Divider
                              const PopupMenuItem(
                                enabled: false,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1.2,
                                  height: 8,
                                ),
                              ),
                              const PopupMenuItem(
                                value: 2,
                                child: Row(
                                  children: [
                                    Icon(Icons.logout, size: 20),
                                    SizedBox(width: 8),
                                    Text('Logout'),
                                  ],
                                ),
                              ),
                            ],
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg',
                            ),
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),

                  body: AppBackground(
                    child: Center(
                      child: Text(
                        selectedPage.toString(),
                        style: TextStyle(
                          fontSize: 86,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  bottomNavigationBar: CustomBottomNav(
                    selectedIndex: selectedPage,
                    onTap: (index) {
                      selectedPageNotifier.value = index;
                    },
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
