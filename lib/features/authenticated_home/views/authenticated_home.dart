import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/features/authenticated_home/notifier/notifiers.dart';
import 'package:pashboi/features/authenticated_home/widgets/app_bottom_navigation_bar.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/authenticated_home/bloc/auth_bloc.dart';

class AuthenticatedHome extends StatefulWidget {
  const AuthenticatedHome({super.key});

  @override
  State<AuthenticatedHome> createState() => _AuthenticatedHomeState();
}

class _AuthenticatedHomeState extends State<AuthenticatedHome> {
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
        child: ValueListenableBuilder(
          valueListenable: selectedPageNotifier,
          builder:
              (context, selectedPage, child) => Scaffold(
                appBar: AppBar(
                  title: Text('Home'),
                  automaticallyImplyLeading: false,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          // Handle profile tap
                        },
                        child: CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                            'https://example.com/profile.jpg', // Replace with your image URL or use AssetImage
                          ),
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // context.read<AuthBloc>().add(LogoutRequested());
                      },
                      icon: Icon(Icons.logout),
                      tooltip: 'Logout',
                    ),
                  ],
                ),
                body: SizedBox.shrink(),
                bottomNavigationBar: CustomBottomNav(
                  selectedIndex: selectedPage,
                  onTap: (index) {
                    selectedPageNotifier.value = index;
                  },
                ),
              ),
        ),
      ),
    );
  }
}
