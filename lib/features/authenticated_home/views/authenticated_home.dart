import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/authenticated_home/bloc/auth_bloc.dart';
import 'package:pashboi/features/authenticated_home/widgets/home_screen_body.dart';

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
        child: HomeScreenBody(),
      ),
    );
  }
}
